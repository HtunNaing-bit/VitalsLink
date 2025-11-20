import 'package:flutter/material.dart';

import '../../../core/models/ai_message.dart';
import '../../../core/utils/formatters.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});

  final AIMessage message;

  @override
  Widget build(BuildContext context) {
    final isAssistant = message.role != ChatRole.user;
    final alignment =
        isAssistant ? Alignment.centerLeft : Alignment.centerRight;
    final color = isAssistant
        ? Theme.of(context).colorScheme.primary.withAlpha((0.16 * 255).round())
        : Theme.of(
            context,
          ).colorScheme.secondary.withAlpha((0.22 * 255).round());

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 420),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isAssistant ? 8 : 28),
            topRight: Radius.circular(isAssistant ? 28 : 8),
            bottomLeft: const Radius.circular(28),
            bottomRight: const Radius.circular(28),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.content, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 6),
            Text(
              formatTime(message.timestamp),
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
