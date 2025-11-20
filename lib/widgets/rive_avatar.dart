import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// Rive avatar widget with state machine support
/// Supports idle, speak, listen states
class RiveAvatar extends StatefulWidget {
  final double size;
  final String assetPath;
  final String stateMachineName;
  final String? currentState;
  final VoidCallback? onTap;

  const RiveAvatar({
    super.key,
    this.size = 120,
    this.assetPath = 'assets/rive/avatar.riv',
    this.stateMachineName = 'State Machine 1',
    this.currentState,
    this.onTap,
  });

  @override
  State<RiveAvatar> createState() => _RiveAvatarState();
}

class _RiveAvatarState extends State<RiveAvatar> {
  StateMachineController? _controller;
  Artboard? _riveArtboard;
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _loadRive();
  }

  Future<void> _loadRive() async {
    try {
      final data = await RiveFile.asset(widget.assetPath);
      final artboard = data.mainArtboard;

      // Try to find state machine
      final controller = StateMachineController.fromArtboard(
        artboard,
        widget.stateMachineName,
      );

      if (controller != null) {
        artboard.addController(controller);
        setState(() {
          _controller = controller;
          _riveArtboard = artboard;
          _isLoading = false;
        });

        // Set initial state if provided
        if (widget.currentState != null) {
          _setState(widget.currentState!);
        }
      } else {
        setState(() {
          _isError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isError = true;
        _isLoading = false;
      });
    }
  }

  void _setState(String stateName) {
    if (_controller == null) return;

    // Find and trigger the state
    final inputs = _controller!.inputs;
    for (final input in inputs) {
      if (input.name == stateName && input is SMITrigger) {
        input.value = true;
        break;
      }
    }
  }

  @override
  void didUpdateWidget(RiveAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentState != widget.currentState &&
        widget.currentState != null) {
      _setState(widget.currentState!);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        width: widget.size,
        height: widget.size,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_isError || _riveArtboard == null) {
      // Fallback to placeholder
      return GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          ),
          child: Icon(
            Icons.person,
            size: widget.size * 0.6,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Rive(
          artboard: _riveArtboard!,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
