import 'package:flutter/material.dart';

class GradientButton extends StatefulWidget {
  const GradientButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.gradient,
    this.padding = const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
  });

  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final Gradient? gradient;
  final EdgeInsets padding;

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.icon != null) ...[
          Icon(widget.icon, color: Colors.white),
          const SizedBox(width: 12),
        ],
        Text(
          widget.label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );

    return ScaleTransition(
      scale: _scaleAnimation,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: widget.gradient ??
              LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            child: Container(padding: widget.padding, child: child),
          ),
        ),
      ),
    );
  }
}
