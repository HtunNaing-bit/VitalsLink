import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/services/analytics_service.dart';
import '../../../../core/utils/motion_utils.dart';
import '../../../../widgets/animated_gradient_bg.dart';
import '../../../../src/ui/components/glass_card.dart';
import '../../../../widgets/rive_avatar.dart';
import '../../../../widgets/pro_bottom_nav.dart';

/// AI Coach chat interface with Rive avatar
class AICoachScreen extends ConsumerStatefulWidget {
  const AICoachScreen({super.key});

  @override
  ConsumerState<AICoachScreen> createState() => _AICoachScreenState();
}

class _AICoachScreenState extends ConsumerState<AICoachScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;
  String _avatarState = 'idle';

  @override
  void initState() {
    super.initState();
    _messages.add(ChatMessage(
      text: 'Hello! I\'m your AI health coach. How can I help you today?',
      isUser: false,
      timestamp: DateTime.now(),
    ));
    AnalyticsService().trackScreenView('ai_coach');
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isTyping = true;
      _avatarState = 'listen';
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate AI response
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isTyping = false;
        _avatarState = 'speak';
        _messages.add(ChatMessage(
          text:
              'That\'s a great question! Based on your recent data, I recommend focusing on getting 7-8 hours of sleep consistently. Would you like me to help you set a sleep goal?',
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });

      // Reset avatar to idle after speaking
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _avatarState = 'idle';
          });
        }
      });

      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: MotionUtils.getDuration(context, MotionTokens.medium),
          curve: MotionUtils.getCurve(context, MotionTokens.standardCurve),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _CoachHeader(),

              // Avatar
              RiveAvatar(
                size: 120,
                currentState: _avatarState,
              )
                  .animate()
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1.0, 1.0),
                    delay: MotionTokens.small,
                    duration: MotionUtils.getDuration(
                      context,
                      MotionTokens.medium,
                    ),
                  )
                  .fadeIn(
                    delay: MotionTokens.small,
                    duration: MotionUtils.getDuration(
                      context,
                      MotionTokens.medium,
                    ),
                  ),

              const SizedBox(height: 16),

              // Chat messages
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length && _isTyping) {
                      return _TypingIndicator();
                    }
                    return _ChatBubble(message: _messages[index]);
                  },
                ),
              ),

              // Quick replies
              if (_messages.length == 1) _QuickReplies(onReply: _sendMessage),

              // Input area
              _ChatInput(
                controller: _messageController,
                onSend: _sendMessage,
              ),

              // Bottom navigation
              ProBottomNav(
                currentIndex: 1,
                onTap: (index) {
                  switch (index) {
                    case 0:
                      context.go('/dashboard');
                      break;
                    case 1:
                      context.go('/coach');
                      break;
                    case 2:
                      context.go('/insights');
                      break;
                    case 3:
                      context.go('/profile');
                      break;
                  }
                },
                items: const [
                  NavItem(
                      icon: Icons.dashboard,
                      label: 'Dashboard',
                      route: '/dashboard'),
                  NavItem(
                      icon: Icons.chat_bubble, label: 'Coach', route: '/coach'),
                  NavItem(
                      icon: Icons.insights,
                      label: 'Insights',
                      route: '/insights'),
                  NavItem(
                      icon: Icons.person, label: 'Profile', route: '/profile'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoachHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/dashboard'),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Coach',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  'Your personal health assistant',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: Show options menu
            },
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.isUser;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: theme.colorScheme.primary,
              child: const Icon(Icons.smart_toy, size: 16),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: GlassCard(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: theme.colorScheme.secondary,
              child: const Icon(Icons.person, size: 16),
            ),
          ],
        ],
      ),
    )
        .animate()
        .fadeIn(
          duration: MotionUtils.getDuration(context, MotionTokens.small),
        )
        .slideY(
          begin: 0.1,
          end: 0,
          duration: MotionUtils.getDuration(context, MotionTokens.small),
        );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }
}

class _TypingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.smart_toy, size: 16),
          ),
          const SizedBox(width: 8),
          const GlassCard(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TypingDot(delay: 0),
                SizedBox(width: 4),
                _TypingDot(delay: 200),
                SizedBox(width: 4),
                _TypingDot(delay: 400),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TypingDot extends StatelessWidget {
  final int delay;

  const _TypingDot({required this.delay});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .fadeIn(
          delay: Duration(milliseconds: delay),
          duration: const Duration(milliseconds: 600),
        )
        .then()
        .fadeOut(duration: const Duration(milliseconds: 600));
  }
}

class _QuickReplies extends StatelessWidget {
  final Function(String) onReply;

  const _QuickReplies({required this.onReply});

  @override
  Widget build(BuildContext context) {
    final suggestions = [
      'How can I improve my sleep?',
      'What\'s my heart rate trend?',
      'Set a new goal',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: suggestions.map((suggestion) {
          return ActionChip(
            label: Text(suggestion),
            onPressed: () => onReply(suggestion),
          );
        }).toList(),
      ),
    );
  }
}

class _ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSend;

  const _ChatInput({
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onSubmitted: onSend,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => onSend(controller.text),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}
