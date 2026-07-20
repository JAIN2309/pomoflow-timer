import 'dart:ui';
import 'package:flutter/material.dart';
import '../../models/pomodoro_mode.dart';

class CompletionDialog extends StatelessWidget {
  final PomodoroMode currentMode;
  final VoidCallback onClose;
  final VoidCallback onStartNext;

  const CompletionDialog({
    super.key,
    required this.currentMode,
    required this.onClose,
    required this.onStartNext,
  });

  static Future<void> show({
    required BuildContext context,
    required PomodoroMode currentMode,
    required VoidCallback onStartNext,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CompletionDialog(
          currentMode: currentMode,
          onClose: () => Navigator.of(context).pop(),
          onStartNext: () {
            Navigator.of(context).pop();
            onStartNext();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = currentMode.accentColor;
    final nextMode = currentMode == PomodoroMode.focus
        ? PomodoroMode.shortBreak
        : PomodoroMode.focus;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Dialog(
        backgroundColor: const Color(0xFF2A2A3E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: accentColor.withValues(alpha: 0.3), width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: accentColor, width: 2),
                ),
                child: Icon(
                  currentMode == PomodoroMode.focus
                      ? Icons.celebration_rounded
                      : Icons.battery_charging_full_rounded,
                  color: accentColor,
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                currentMode == PomodoroMode.focus
                    ? 'Focus Session Done!'
                    : 'Break Finished!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                currentMode == PomodoroMode.focus
                    ? 'Incredible job! You stayed focused for ${currentMode.defaultMinutes} minutes. Ready for a break?'
                    : 'Hope you had a nice rest. Ready to jump back into focus?',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: onClose,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onStartNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        nextMode == PomodoroMode.focus ? 'Start Break' : 'Start Focus',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
