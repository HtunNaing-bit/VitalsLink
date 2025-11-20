import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/models/consent_entry.dart';
import '../../core/theme/colors.dart';
import 'vitalslink_card.dart';

/// ConsentLedgerView - Displays consent ledger entries
/// Shows timestamp, action, scope, source, and signature hash
class ConsentLedgerView extends StatelessWidget {
  const ConsentLedgerView({
    super.key,
    required this.entries,
    this.onExport,
    this.onRevoke,
  });

  final List<ConsentEntry> entries;
  final VoidCallback? onExport;
  final ValueChanged<String>? onRevoke;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (entries.isEmpty) {
      return VitalsLinkCard(
        child: Column(
          children: [
            const Icon(
              Icons.lock_outline,
              color: VitalsLinkColors.text300,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'No consent entries yet',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: VitalsLinkColors.text300,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Consent entries will appear here when you grant or revoke permissions.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: VitalsLinkColors.text500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with export button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Consent Ledger',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: VitalsLinkColors.text100,
              ),
            ),
            if (onExport != null)
              TextButton.icon(
                onPressed: onExport,
                icon: const Icon(Icons.download_outlined),
                label: const Text('Export PDF'),
                style: TextButton.styleFrom(
                  foregroundColor: VitalsLinkColors.primary500,
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        // Entries list
        ...entries.map((entry) => _ConsentEntryCard(
              entry: entry,
              onRevoke: onRevoke,
            )),
      ],
    );
  }
}

class _ConsentEntryCard extends StatelessWidget {
  const _ConsentEntryCard({
    required this.entry,
    this.onRevoke,
  });

  final ConsentEntry entry;
  final ValueChanged<String>? onRevoke;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d, y • h:mm a');

    return VitalsLinkCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Action badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getActionColor(entry.action).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  entry.action.name.toUpperCase(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: _getActionColor(entry.action),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Timestamp
              Text(
                dateFormat.format(entry.timestamp),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: VitalsLinkColors.text300,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Scope details
          if (entry.scope.dataTypes.isNotEmpty) ...[
            Text(
              'Data Types:',
              style: theme.textTheme.bodySmall?.copyWith(
                color: VitalsLinkColors.text300,
              ),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: entry.scope.dataTypes
                  .map(
                    (type) => Chip(
                      label: Text(type),
                      backgroundColor: VitalsLinkColors.surface700,
                      labelStyle: theme.textTheme.bodySmall?.copyWith(
                        color: VitalsLinkColors.text100,
                      ),
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 12),
          ],
          // Source
          if (entry.source != null) ...[
            Row(
              children: [
                const Icon(
                  Icons.source_outlined,
                  size: 16,
                  color: VitalsLinkColors.text300,
                ),
                const SizedBox(width: 8),
                Text(
                  'Source: ${entry.source}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: VitalsLinkColors.text300,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
          // Signature hash
          if (entry.signatureHash != null) ...[
            Row(
              children: [
                const Icon(
                  Icons.fingerprint_outlined,
                  size: 16,
                  color: VitalsLinkColors.text300,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Hash: ${entry.signatureHash!.substring(0, 16)}...',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: VitalsLinkColors.text500,
                      fontFamily: 'monospace',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
          // Revoke button (if granted)
          if (entry.action == ConsentAction.granted && onRevoke != null)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => onRevoke!(entry.id),
                child: Text(
                  'Revoke',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: VitalsLinkColors.error,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getActionColor(ConsentAction action) {
    switch (action) {
      case ConsentAction.granted:
        return VitalsLinkColors.success;
      case ConsentAction.revoked:
        return VitalsLinkColors.error;
      case ConsentAction.exported:
        return VitalsLinkColors.primary500;
      case ConsentAction.shared:
        return VitalsLinkColors.accent400;
      case ConsentAction.deleted:
        return VitalsLinkColors.text500;
    }
  }
}
