import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  final bool isRunning;
  final Color accentColor;
  final VoidCallback onPlayPause;
  final VoidCallback onReset;
  final VoidCallback onSkip;

  const ControlButtons({
    super.key,
    required this.isRunning,
    required this.accentColor,
    required this.onPlayPause,
    required this.onReset,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSecondaryButton(
          icon: Icons.replay_rounded,
          tooltip: 'Reset Timer',
          onPressed: onReset,
        ),
        const SizedBox(width: 32),
        GestureDetector(
          onTap: onPlayPause,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: accentColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Icon(
                  isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  key: ValueKey<bool>(isRunning),
                  color: Colors.white,
                  size: 38,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 32),
        _buildSecondaryButton(
          icon: Icons.skip_next_rounded,
          tooltip: 'Skip Session',
          onPressed: onSkip,
        ),
      ],
    );
  }

  Widget _buildSecondaryButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A3E),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.05),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white70,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
