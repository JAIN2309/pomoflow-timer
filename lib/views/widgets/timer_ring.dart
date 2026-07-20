import 'package:flutter/material.dart';

class TimerRing extends StatelessWidget {
  final int secondsRemaining;
  final double progress;
  final Color accentColor;
  final String description;

  const TimerRing({
    super.key,
    required this.secondsRemaining,
    required this.progress,
    required this.accentColor,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final minutes = (secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (secondsRemaining % 60).toString().padLeft(2, '0');

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 290,
          height: 290,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: accentColor.withValues(alpha: 0.04),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 280,
          height: 280,
          child: CircularProgressIndicator(
            value: 1.0,
            strokeWidth: 8,
            color: Colors.white.withValues(alpha: 0.03),
          ),
        ),
        SizedBox(
          width: 280,
          height: 280,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: progress, end: progress),
            duration: const Duration(milliseconds: 300),
            builder: (context, value, child) {
              return CircularProgressIndicator(
                value: value,
                strokeWidth: 8,
                color: accentColor,
                strokeCap: StrokeCap.round,
              );
            },
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$minutes:$seconds',
              style: const TextStyle(
                fontSize: 68,
                fontWeight: FontWeight.w200,
                color: Colors.white,
                letterSpacing: -2,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
                color: accentColor.withValues(alpha: 0.8),
              ),
              child: Text(description),
            ),
          ],
        ),
      ],
    );
  }
}
