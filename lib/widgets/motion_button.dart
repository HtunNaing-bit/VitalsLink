import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/utils/motion_utils.dart';

/// Animated button with press scale animation
class MotionButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final bool enabled;

  const MotionButton({
    super.key,
    required this.child,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.borderRadius,
    this.width,
    this.height,
    this.enabled = true,
  });

  @override
  State<MotionButton> createState() => _MotionButtonState();
}

class _MotionButtonState extends State<MotionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: MotionTokens.micro,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: MotionTokens.buttonPressScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enabled && widget.onPressed != null) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enabled && widget.onPressed != null) {
      _controller.reverse();
      widget.onPressed?.call();
    }
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = widget.backgroundColor ?? theme.colorScheme.primary;
    final foregroundColor =
        widget.foregroundColor ?? theme.colorScheme.onPrimary;
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(999);
    final padding = widget.padding ??
        const EdgeInsets.symmetric(horizontal: 24, vertical: 16);

    final shouldReduce = MotionUtils.shouldReduceMotion(context);

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: shouldReduce ? 1.0 : _scaleAnimation.value,
            child: Container(
              width: widget.width,
              height: widget.height,
              padding: padding,
              decoration: BoxDecoration(
                color: widget.enabled
                    ? backgroundColor
                    : backgroundColor.withOpacity(0.5),
                borderRadius: borderRadius,
              ),
              child: DefaultTextStyle(
                style: TextStyle(color: foregroundColor),
                child: widget.child,
              ),
            ),
          );
        },
      ),
    ).animate().fadeIn(
          duration: MotionUtils.getDuration(context, MotionTokens.small),
          curve: MotionUtils.getCurve(context, MotionTokens.standardCurve),
        );
  }
}
