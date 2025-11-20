import 'package:flutter/material.dart';

import '../core/theme/gradients.dart';
import '../core/utils/motion_utils.dart';

/// Animated gradient background widget
/// Respects reduced motion preferences
class AnimatedGradientBackground extends StatefulWidget {
  final Widget child;
  final Gradient? gradient;
  final bool animate;

  const AnimatedGradientBackground({
    super.key,
    required this.child,
    this.gradient,
    this.animate = true,
  });

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _animationStarted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check reduced motion after dependencies are available
    if (!_animationStarted &&
        widget.animate &&
        !MotionUtils.shouldReduceMotion(context)) {
      _animationStarted = true;
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use theme-appropriate gradient based on brightness
    final brightness = Theme.of(context).brightness;
    final defaultGradient = brightness == Brightness.light
        ? VitalsLinkGradients.lightBackground
        : VitalsLinkGradients.darkBackground;
    final gradient = widget.gradient ?? defaultGradient;
    final shouldReduce = MotionUtils.shouldReduceMotion(context);

    if (!widget.animate || shouldReduce) {
      return Container(
        decoration: BoxDecoration(gradient: gradient),
        child: widget.child,
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                gradient.colors[0],
                gradient.colors[1],
                gradient.colors[2 % gradient.colors.length],
              ],
              stops: [
                0.0,
                0.5 + (_controller.value * 0.3),
                1.0,
              ],
            ),
          ),
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }
}
