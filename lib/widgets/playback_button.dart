import 'package:flutter/material.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PlaybackButton extends StatefulWidget {
  const PlaybackButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  PlaybackButtonState createState() => PlaybackButtonState();
}

class PlaybackButtonState extends State<PlaybackButton>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = true;
  bool _isIconVisible = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  static const _iconSize = 80.0;
  static const _blurRadius = 10.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 160),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      _isIconVisible = true;
    });

    _animationController.forward().then((_) {
      _animationController.reverse().then((_) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            setState(() {
              _isIconVisible = false;
            });
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return GestureDetector(
      onTap: () {
        _togglePlayPause();
        widget.onTap();
      },
      child: AnimatedOpacity(
        opacity: _isIconVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 100),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Icon(
            _isPlaying
                ? PhosphorIcons.pauseCircle(PhosphorIconsStyle.fill)
                : PhosphorIcons.playCircle(PhosphorIconsStyle.fill),
            size: _iconSize,
            color: theme.colorScheme.surface.withAlpha(150),
            shadows: [
              BoxShadow(
                color: theme.colorScheme.onSurface.withAlpha(150),
                blurRadius: _blurRadius,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
