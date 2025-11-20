import 'package:flutter/material.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

/// ReorderableCardGrid - Drag-and-drop card reordering
/// Saves card order to preferences
class ReorderableCardGrid extends StatelessWidget {
  const ReorderableCardGrid({
    super.key,
    required this.children,
    this.onReorder,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 16,
    this.crossAxisSpacing = 16,
  });

  final List<Widget> children;
  final ValueChanged<int>? onReorder;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  @override
  Widget build(BuildContext context) {
    return ReorderableGridView.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childAspectRatio: 0.85,
      onReorder: (oldIndex, newIndex) {
        if (onReorder != null) {
          onReorder!(oldIndex);
        }
      },
      children: children
          .asMap()
          .entries
          .map(
            (entry) => Container(
              key: ValueKey(entry.key),
              child: entry.value,
            ),
          )
          .toList(),
    );
  }
}

/// Card reorder handler
class CardReorderHandler {
  static void handleReorder(
    int oldIndex,
    int newIndex,
    List<String> cardOrder,
  ) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = cardOrder.removeAt(oldIndex);
    cardOrder.insert(newIndex, item);
    // TODO: Save to preferences
  }
}
