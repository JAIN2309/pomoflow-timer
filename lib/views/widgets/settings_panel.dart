import 'package:flutter/material.dart';
import '../../models/pomodoro_mode.dart';

class SettingsPanel extends StatelessWidget {
  final int focusMinutes;
  final int shortBreakMinutes;
  final int longBreakMinutes;
  final ValueChanged<int> onFocusMinutesChanged;
  final ValueChanged<int> onShortBreakMinutesChanged;
  final ValueChanged<int> onLongBreakMinutesChanged;

  const SettingsPanel({
    super.key,
    required this.focusMinutes,
    required this.shortBreakMinutes,
    required this.longBreakMinutes,
    required this.onFocusMinutesChanged,
    required this.onShortBreakMinutesChanged,
    required this.onLongBreakMinutesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStepperRow(
            context,
            title: 'Focus Session',
            value: focusMinutes,
            accentColor: PomodoroMode.focus.accentColor,
            onChanged: onFocusMinutesChanged,
          ),
          const Divider(color: Colors.white10, height: 20),
          _buildStepperRow(
            context,
            title: 'Short Break',
            value: shortBreakMinutes,
            accentColor: PomodoroMode.shortBreak.accentColor,
            onChanged: onShortBreakMinutesChanged,
          ),
          const Divider(color: Colors.white10, height: 20),
          _buildStepperRow(
            context,
            title: 'Long Break',
            value: longBreakMinutes,
            accentColor: PomodoroMode.longBreak.accentColor,
            onChanged: onLongBreakMinutesChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildStepperRow(
    BuildContext context, {
    required String title,
    required int value,
    required Color accentColor,
    required ValueChanged<int> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
        ),
        Row(
          children: [
            _buildStepperButton(
              icon: Icons.remove_rounded,
              onPressed: () => onChanged(value - 1),
            ),
            Container(
              width: 56,
              alignment: Alignment.center,
              child: Text(
                '${value}m',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
            ),
            _buildStepperButton(
              icon: Icons.add_rounded,
              onPressed: () => onChanged(value + 1),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepperButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.white.withValues(alpha: 0.04),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            size: 16,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
