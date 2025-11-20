import 'package:flutter/material.dart';

import '../../../core/models/health.dart';
import '../../../../src/ui/components/glass_card.dart';

class ConnectorTile extends StatelessWidget {
  const ConnectorTile({super.key, required this.connector});

  final Connector connector;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GlassCard(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: connector.connected
                  ? theme.colorScheme.secondary.withAlpha((0.18 * 255).round())
                  : theme.colorScheme.primary.withAlpha((0.18 * 255).round()),
              foregroundColor: connector.connected
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.primary,
              child: Icon(
                connector.connected ? Icons.verified_user : Icons.link_off,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(connector.provider, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(
                    connector.description,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: connector.connected
                            ? Colors.greenAccent
                            : Colors.orangeAccent,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        connector.connected ? 'Connected' : 'Pending',
                        style: theme.textTheme.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FilledButton.tonal(
              onPressed: () {},
              child: Text(connector.connected ? 'Manage' : 'Connect'),
            ),
          ],
        ),
      ),
    );
  }
}
