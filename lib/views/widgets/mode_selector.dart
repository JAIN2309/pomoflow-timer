import 'package:flutter/material.dart';
import '../../models/pomodoro_mode.dart';

class ModeSelector extends StatelessWidget {
  final PomodoroMode currentMode;
  final ValueChanged<PomodoroMode> onModeSelected;

  const ModeSelector({
    super.key,
    required this.currentMode,
    required this.onModeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: PomodoroMode.values.map((mode) {
          final isSelected = currentMode == mode;
          return GestureDetector(
            onTap: () => onModeSelected(mode),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? mode.accentColor.withValues(alpha: 0.15) : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected ? mode.accentColor.withValues(alpha: 0.5) : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Text(
                mode.name,
                style: TextStyle(
                  color: isSelected ? mode.accentColor : Colors.white60,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
