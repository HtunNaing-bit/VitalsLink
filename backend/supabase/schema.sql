-- VitalsLink — Calm Vitality Database Schema
-- Supabase Postgres schema with RLS policies

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table (extends Supabase auth.users)
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT UNIQUE NOT NULL,
  full_name TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  preferences JSONB DEFAULT '{
    "darkMode": true,
    "notificationsEnabled": true,
    "voiceCoachEnabled": false,
    "privacyLevel": "vault",
    "mockMode": false
  }'::jsonb
);

-- Data sources (health connectors)
CREATE TABLE IF NOT EXISTS public.sources (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  provider TEXT NOT NULL, -- 'apple_health', 'fitbit', 'google_fit', etc.
  status TEXT NOT NULL DEFAULT 'disconnected', -- 'disconnected', 'connecting', 'connected', 'error', 'syncing'
  last_sync TIMESTAMPTZ,
  config JSONB DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, provider)
);

-- Health metrics
CREATE TABLE IF NOT EXISTS public.metrics (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  timestamp TIMESTAMPTZ NOT NULL,
  type TEXT NOT NULL, -- 'heart_rate', 'hrv', 'steps', 'sleep_duration', etc.
  value DOUBLE PRECISION NOT NULL,
  unit TEXT,
  source_id UUID REFERENCES public.sources(id) ON DELETE SET NULL,
  metadata JSONB DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  INDEX idx_metrics_user_timestamp (user_id, timestamp DESC),
  INDEX idx_metrics_type (type)
);

-- Consent ledger (immutable audit trail)
CREATE TABLE IF NOT EXISTS public.consent_ledger (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  action TEXT NOT NULL, -- 'granted', 'revoked', 'exported', 'shared', 'deleted'
  scope JSONB NOT NULL, -- { "dataTypes": [...], "permissions": [...], "provider": "..." }
  source TEXT, -- 'apple_health', 'fitbit', etc.
  signature_hash TEXT, -- SHA-256 hash of consent entry for immutability
  metadata JSONB DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  INDEX idx_consent_user_timestamp (user_id, timestamp DESC)
);

-- AI conversations
CREATE TABLE IF NOT EXISTS public.ai_conversations (
  id TEXT PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  role TEXT NOT NULL, -- 'user', 'assistant'
  content TEXT NOT NULL,
  data_points TEXT[], -- Array of data points used in response
  confidence DOUBLE PRECISION,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  INDEX idx_ai_user_created (user_id, created_at DESC)
);

-- Goals
CREATE TABLE IF NOT EXISTS public.goals (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  type TEXT NOT NULL, -- 'sleep', 'heart', 'activity', 'stress', 'energy', 'weight'
  target_value DOUBLE PRECISION,
  current_value DOUBLE PRECISION,
  intensity DOUBLE PRECISION DEFAULT 0.5, -- 0.0 to 1.0
  status TEXT NOT NULL DEFAULT 'active', -- 'active', 'completed', 'paused'
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  INDEX idx_goals_user_status (user_id, status)
);

-- Timeline events
CREATE TABLE IF NOT EXISTS public.timeline_events (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  icon TEXT, -- Emoji or icon identifier
  event_type TEXT NOT NULL, -- 'ai_insight', 'goal_achieved', 'clinician_share', 'export', etc.
  consent_entry_id UUID REFERENCES public.consent_ledger(id) ON DELETE SET NULL,
  metric_id UUID REFERENCES public.metrics(id) ON DELETE SET NULL,
  timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  metadata JSONB DEFAULT '{}'::jsonb,
  INDEX idx_timeline_user_timestamp (user_id, timestamp DESC)
);

-- Row Level Security (RLS) Policies

-- Enable RLS on all tables
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sources ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.metrics ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.consent_ledger ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ai_conversations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.goals ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.timeline_events ENABLE ROW LEVEL SECURITY;

-- Profiles policies
CREATE POLICY "Users can view own profile"
  ON public.profiles FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Users can update own profile"
  ON public.profiles FOR UPDATE
  USING (auth.uid() = id);

-- Sources policies
CREATE POLICY "Users can view own sources"
  ON public.sources FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own sources"
  ON public.sources FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own sources"
  ON public.sources FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own sources"
  ON public.sources FOR DELETE
  USING (auth.uid() = user_id);

-- Metrics policies
CREATE POLICY "Users can view own metrics"
  ON public.metrics FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own metrics"
  ON public.metrics FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own metrics"
  ON public.metrics FOR DELETE
  USING (auth.uid() = user_id);

-- Consent ledger policies (immutable - no updates/deletes)
CREATE POLICY "Users can view own consent ledger"
  ON public.consent_ledger FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own consent entries"
  ON public.consent_ledger FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- AI conversations policies
CREATE POLICY "Users can view own conversations"
  ON public.ai_conversations FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own conversations"
  ON public.ai_conversations FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Goals policies
CREATE POLICY "Users can view own goals"
  ON public.goals FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own goals"
  ON public.goals FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own goals"
  ON public.goals FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own goals"
  ON public.goals FOR DELETE
  USING (auth.uid() = user_id);

-- Timeline events policies
CREATE POLICY "Users can view own timeline events"
  ON public.timeline_events FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own timeline events"
  ON public.timeline_events FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Functions

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers for updated_at
CREATE TRIGGER update_profiles_updated_at
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_sources_updated_at
  BEFORE UPDATE ON public.sources
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_goals_updated_at
  BEFORE UPDATE ON public.goals
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Function to generate signature hash for consent entries
CREATE OR REPLACE FUNCTION generate_consent_signature(
  p_user_id UUID,
  p_action TEXT,
  p_scope JSONB,
  p_timestamp TIMESTAMPTZ
)
RETURNS TEXT AS $$
BEGIN
  RETURN encode(
    digest(
      p_user_id::TEXT || p_action || p_scope::TEXT || p_timestamp::TEXT,
      'sha256'
    ),
    'hex'
  );
END;
$$ LANGUAGE plpgsql;

-- Seed data for demo mode
INSERT INTO public.profiles (id, email, full_name, preferences)
VALUES (
  '00000000-0000-0000-0000-000000000000',
  'demo@vitalslink.app',
  'Demo User',
  '{
    "darkMode": true,
    "notificationsEnabled": true,
    "voiceCoachEnabled": false,
    "privacyLevel": "vault",
    "mockMode": true
  }'::jsonb
) ON CONFLICT (id) DO NOTHING;

