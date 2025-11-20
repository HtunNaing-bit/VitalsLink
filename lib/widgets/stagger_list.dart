import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/utils/motion_utils.dart';

/// Staggered list animation widget
/// Animates children with a delay between each item
class StaggerList extends StatelessWidget {
  final List<Widget> children;
  final Duration? staggerStep;
  final Duration? duration;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  const StaggerList({
    super.key,
    required this.children,
    this.staggerStep,
    this.duration,
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final step = staggerStep ?? MotionTokens.staggerStep;
    final effectiveDuration = duration ?? MotionTokens.medium;
    final shouldReduce = MotionUtils.shouldReduceMotion(context);

    final animatedChildren = children.asMap().entries.map((entry) {
      final index = entry.key;
      final child = entry.value;

      if (shouldReduce) {
        return child;
      }

      return child
          .animate(
            delay: step * index,
          )
          .fadeIn(
            duration: MotionUtils.getDuration(context, effectiveDuration),
            curve: MotionUtils.getCurve(context, MotionTokens.standardCurve),
          )
          .slideY(
            begin: MotionTokens.cardEntranceTranslate / 100,
            end: 0,
            duration: MotionUtils.getDuration(context, effectiveDuration),
            curve: MotionUtils.getCurve(context, MotionTokens.standardCurve),
          );
    }).toList();

    if (scrollDirection == Axis.horizontal) {
      return ListView(
        scrollDirection: scrollDirection,
        physics: physics ?? const NeverScrollableScrollPhysics(),
        padding: padding,
        shrinkWrap: true,
        children: animatedChildren,
      );
    }

    return Column(
      children: animatedChildren,
    );
  }
}
