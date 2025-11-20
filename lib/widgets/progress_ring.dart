import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../core/theme/colors.dart';
import '../core/utils/motion_utils.dart';

/// Animated progress ring widget
/// Shows circular progress with animated stroke and number counting
class ProgressRing extends StatefulWidget {
  final double progress; // 0.0 to 1.0
  final double size;
  final double strokeWidth;
  final Color? color;
  final Color? backgroundColor;
  final Widget? child;
  final bool showPercentage;
  final String? label;
  final Duration animationDuration;

  const ProgressRing({
    super.key,
    required this.progress,
    this.size = 120,
    this.strokeWidth = 8,
    this.color,
    this.backgroundColor,
    this.child,
    this.showPercentage = false,
    this.label,
    this.animationDuration = const Duration(milliseconds: 600),
  });

  @override
  State<ProgressRing> createState() => _ProgressRingState();
}

class _ProgressRingState extends State<ProgressRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late Animation<double> _numberAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0,
      end: widget.progress,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: MotionTokens.easeOutCubic,
    ));

    _numberAnimation = Tween<double>(
      begin: 0,
      end: widget.progress * 100,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: MotionTokens.easeOutCubic,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check reduced motion after dependencies are available
    if (!MotionUtils.shouldReduceMotion(context)) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(ProgressRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _progressAnimation = Tween<double>(
        begin: _progressAnimation.value,
        end: widget.progress,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: MotionTokens.easeOutCubic,
      ));

      _numberAnimation = Tween<double>(
        begin: _numberAnimation.value,
        end: widget.progress * 100,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: MotionTokens.easeOutCubic,
      ));

      _controller.reset();
      // Check reduced motion in build method instead
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !MotionUtils.shouldReduceMotion(context)) {
          _controller.forward();
        } else if (mounted) {
          _controller.value = 1.0;
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? VitalsLinkColors.primary500;
    final backgroundColor = widget.backgroundColor ??
        (Theme.of(context).brightness == Brightness.dark
            ? VitalsLinkColors.surface600
            : Colors.grey.shade200);

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _ProgressRingPainter(
              progress: _progressAnimation.value,
              strokeWidth: widget.strokeWidth,
              color: color,
              backgroundColor: backgroundColor,
            ),
            child: Center(
              child: widget.child ??
                  (widget.showPercentage
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${_numberAnimation.value.toInt()}%',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: color,
                                  ),
                            ),
                            if (widget.label != null)
                              Text(
                                widget.label!,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                          ],
                        )
                      : const SizedBox.shrink()),
            ),
          );
        },
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color color;
  final Color backgroundColor;

  _ProgressRingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
