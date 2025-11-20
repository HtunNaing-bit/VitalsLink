import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../components/glass_card.dart';
import '../../../utils/style_tokens.dart';
import '../../../services/ai_service.dart';

/// AI Chat Screen ("Ask VitalsLink")
class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  final AIService _aiService = AIService();
  bool _isTyping = false;

  final List<String> _examplePrompts = [
    'Why am I tired?',
    'Plan a recovery day.',
    'Summarize my week.',
    'How can I improve my sleep?',
    'What should I eat today?',
    'How did my workout yesterday affect my sleep?',
  ];

  @override
  void initState() {
    super.initState();
    // Will be set in build method with localization
  }

  void _initializeMessages(BuildContext context) {
    if (_messages.isEmpty) {
      final l10n = AppLocalizations.of(context)!;
      _messages.add(ChatMessage(
        text: l10n.helloImVitalsLink,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    }
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
    });

    _messageController.clear();
    _scrollToBottom();

    try {
      final response = await _aiService.chat(text);
      setState(() {
        _messages.add(ChatMessage(
          text: response.message,
          isUser: false,
          timestamp: DateTime.now(),
        ));
        _isTyping = false;
      });
      _scrollToBottom();
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _messages.add(ChatMessage(
          text: l10n.sorryIEncounteredAnError,
          isUser: false,
          timestamp: DateTime.now(),
        ));
        _isTyping = false;
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    _initializeMessages(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/dashboard'),
        ),
        title: Text(l10n.askVitalsLink),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // Show help dialog
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Example Prompts Carousel
          if (_messages.length == 1)
            Container(
              height: 100,
              padding:
                  const EdgeInsets.symmetric(vertical: StyleTokens.spacing3),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                    horizontal: StyleTokens.spacing4),
                itemCount: _examplePrompts.length,
                itemBuilder: (context, index) {
                  final prompt = _examplePrompts[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: StyleTokens.spacing3),
                    child: GlassCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: StyleTokens.spacing4,
                        vertical: StyleTokens.spacing3,
                      ),
                      onTap: () => _sendMessage(prompt),
                      child: Text(
                        prompt,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: themeManager.currentTheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  );
                },
              ),
            ),
          // Messages List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(StyleTokens.spacing4),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length) {
                  // Typing indicator
                  return _buildTypingIndicator(context, themeManager);
                }
                return _buildMessageBubble(
                    context, _messages[index], themeManager, isDark);
              },
            ),
          ),
          // Input Field
          Container(
            padding: const EdgeInsets.all(StyleTokens.spacing4),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.1),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Ask VitalsLink...',
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(StyleTokens.radiusLarge),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: StyleTokens.spacing4,
                        vertical: StyleTokens.spacing3,
                      ),
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                const SizedBox(width: StyleTokens.spacing3),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: themeManager.currentTheme.primary,
                  ),
                  onPressed: () => _sendMessage(_messageController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(
    BuildContext context,
    ChatMessage message,
    ThemeManager themeManager,
    bool isDark,
  ) {
    final isUser = message.isUser;

    return Padding(
      padding: const EdgeInsets.only(bottom: StyleTokens.spacing3),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor:
                  themeManager.currentTheme.primary.withOpacity(0.1),
              child: Icon(
                Icons.health_and_safety,
                size: 16,
                color: themeManager.currentTheme.primary,
              ),
            ),
            const SizedBox(width: StyleTokens.spacing2),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(StyleTokens.spacing3),
              decoration: BoxDecoration(
                color: isUser
                    ? themeManager.currentTheme.primary
                    : (isDark ? const Color(0xFF1C1C1E) : Colors.white),
                borderRadius: BorderRadius.circular(StyleTokens.radiusMedium),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: isUser
                      ? themeManager.currentTheme.accentContrast
                      : StyleTokens.getTextPrimaryStatic(isDark: isDark),
                ),
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: StyleTokens.spacing2),
            CircleAvatar(
              radius: 16,
              backgroundColor:
                  themeManager.currentTheme.primary.withOpacity(0.1),
              child: Icon(
                Icons.person,
                size: 16,
                color: themeManager.currentTheme.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator(
      BuildContext context, ThemeManager themeManager) {
    return Padding(
      padding: const EdgeInsets.only(bottom: StyleTokens.spacing3),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: themeManager.currentTheme.primary.withOpacity(0.1),
            child: Icon(
              Icons.health_and_safety,
              size: 16,
              color: themeManager.currentTheme.primary,
            ),
          ),
          const SizedBox(width: StyleTokens.spacing2),
          Container(
            padding: const EdgeInsets.all(StyleTokens.spacing3),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF1C1C1E)
                  : Colors.white,
              borderRadius: BorderRadius.circular(StyleTokens.radiusMedium),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                const SizedBox(width: 4),
                _buildTypingDot(1),
                const SizedBox(width: 4),
                _buildTypingDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: ThemeManager().currentTheme.primary.withOpacity(0.5),
        shape: BoxShape.circle,
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
