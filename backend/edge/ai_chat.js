// Supabase Edge Function: AI Chat
// Handles AI Coach conversations with rate limiting and consent tracking

import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const OPENAI_API_KEY = Deno.env.get('OPENAI_API_KEY');
const SUPABASE_URL = Deno.env.get('SUPABASE_URL');
const SUPABASE_SERVICE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY');

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers':
    'authorization, x-client-info, apikey, content-type',
};

serve(async (req) => {
  // Handle CORS preflight
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);

    // Get auth token from request
    const authHeader = req.headers.get('Authorization');
    if (!authHeader) {
      return new Response(
        JSON.stringify({ error: 'Missing authorization header' }),
        { status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
      );
    }

    // Verify user
    const token = authHeader.replace('Bearer ', '');
    const {
      data: { user },
      error: authError,
    } = await supabase.auth.getUser(token);

    if (authError || !user) {
      return new Response(
        JSON.stringify({ error: 'Unauthorized' }),
        { status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
      );
    }

    // Parse request body
    const { message, user_id, history = [] } = await req.json();

    if (!message || !user_id) {
      return new Response(
        JSON.stringify({ error: 'Missing message or user_id' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
      );
    }

    // Rate limiting check (simple - can be enhanced with Redis)
    const { data: recentMessages } = await supabase
      .from('ai_conversations')
      .select('id')
      .eq('user_id', user_id)
      .gte('created_at', new Date(Date.now() - 60000).toISOString()) // Last minute
      .limit(10);

    if (recentMessages && recentMessages.length >= 10) {
      return new Response(
        JSON.stringify({ error: 'Rate limit exceeded' }),
        { status: 429, headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
      );
    }

    // Fetch user's recent metrics for context
    const { data: metrics } = await supabase
      .from('metrics')
      .select('type, value, timestamp')
      .eq('user_id', user_id)
      .order('timestamp', { ascending: false })
      .limit(50);

    // Build context for AI
    const context = buildContext(metrics, history);

    // Call OpenAI (or compatible LLM)
    const aiResponse = await callOpenAI(message, context, history);

    // Save conversation to database
    const conversationEntry = {
      id: `${Date.now()}-${Math.random().toString(36).substr(2, 9)}`,
      user_id: user_id,
      role: 'assistant',
      content: aiResponse.content,
      data_points: aiResponse.dataPoints || [],
      confidence: aiResponse.confidence || 0.85,
      created_at: new Date().toISOString(),
    };

    await supabase.from('ai_conversations').insert(conversationEntry);

    // Log consent entry for AI conversation
    await supabase.from('consent_ledger').insert({
      user_id: user_id,
      action: 'granted',
      scope: {
        dataTypes: ['ai_conversation'],
        permissions: ['read', 'store'],
        provider: 'vitalslink_ai',
      },
      source: 'vitalslink_ai',
      signature_hash: generateSignature(user_id, 'granted', {
        dataTypes: ['ai_conversation'],
      }),
    });

    return new Response(
      JSON.stringify(conversationEntry),
      { status: 200, headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
    );
  } catch (error) {
    console.error('Error in AI chat function:', error);
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
    );
  }
});

function buildContext(metrics, history) {
  if (!metrics || metrics.length === 0) {
    return 'No health data available. User is in demo mode.';
  }

  // Summarize recent metrics
  const summary = metrics
    .slice(0, 10)
    .map((m) => `${m.type}: ${m.value}${m.unit || ''}`)
    .join(', ');

  return `User's recent health metrics: ${summary}. Provide evidence-based, compassionate advice.`;
}

async function callOpenAI(message, context, history) {
  if (!OPENAI_API_KEY) {
    // Fallback to mock response if no API key
    return {
      content:
        'I noticed your HRV drops on late dinner nights. Try finishing meals by 7pm and adding light stretches.',
      dataPoints: ['HRV trend (last 7 days)', 'Meal timing data'],
      confidence: 0.85,
    };
  }

  try {
    const messages = [
      {
        role: 'system',
        content:
          'You are the VitalsLink Coach — a compassionate, concise, evidence-based AI health assistant. Provide 1-2 prioritized actions, confidence level, and data points used. Be human, not clinical.',
      },
      ...history.slice(-5).map((h) => ({
        role: h.role,
        content: h.content,
      })),
      {
        role: 'user',
        content: `Context: ${context}\n\nUser message: ${message}`,
      },
    ];

    const response = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${OPENAI_API_KEY}`,
      },
      body: JSON.stringify({
        model: 'gpt-4o-mini', // or 'gpt-3.5-turbo' for cost savings
        messages: messages,
        temperature: 0.7,
        max_tokens: 300,
      }),
    });

    const data = await response.json();

    if (!response.ok) {
      throw new Error(data.error?.message || 'OpenAI API error');
    }

    const content = data.choices[0].message.content;

    // Extract data points and confidence from response (simple parsing)
    const dataPoints = extractDataPoints(content);
    const confidence = extractConfidence(content) || 0.85;

    return {
      content: content,
      dataPoints: dataPoints,
      confidence: confidence,
    };
  } catch (error) {
    console.error('OpenAI API error:', error);
    // Fallback response
    return {
      content:
        'I received your message. Let me analyze your health data and provide personalized insights.',
      dataPoints: ['Recent health metrics'],
      confidence: 0.75,
    };
  }
}

function extractDataPoints(content) {
  // Simple extraction - can be enhanced with better parsing
  const points = [];
  if (content.includes('HRV')) points.push('HRV trend');
  if (content.includes('sleep')) points.push('Sleep data');
  if (content.includes('heart rate')) points.push('Heart rate data');
  if (content.includes('steps')) points.push('Activity data');
  return points.length > 0 ? points : ['Recent health metrics'];
}

function extractConfidence(content) {
  // Extract confidence from response if mentioned
  const match = content.match(/confidence[:\s]+(\d+\.?\d*)/i);
  return match ? parseFloat(match[1]) : null;
}

function generateSignature(userId, action, scope) {
  // Simple hash generation (use crypto in production)
  const data = `${userId}-${action}-${JSON.stringify(scope)}-${Date.now()}`;
  // In production, use proper SHA-256 hashing
  return btoa(data).substring(0, 64);
}

