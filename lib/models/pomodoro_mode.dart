import 'package:flutter/material.dart';

enum PomodoroMode {
  focus,
  shortBreak,
  longBreak,
}

extension PomodoroModeExtension on PomodoroMode {
  String get name {
    switch (this) {
      case PomodoroMode.focus:
        return 'Focus';
      case PomodoroMode.shortBreak:
        return 'Short Break';
      case PomodoroMode.longBreak:
        return 'Long Break';
    }
  }

  int get defaultMinutes {
    switch (this) {
      case PomodoroMode.focus:
        return 25;
      case PomodoroMode.shortBreak:
        return 5;
      case PomodoroMode.longBreak:
        return 15;
    }
  }

  Color get accentColor {
    switch (this) {
      case PomodoroMode.focus:
        return const Color(0xFFFF5252); // Red accent
      case PomodoroMode.shortBreak:
        return const Color(0xFF4CAF50); // Green accent
      case PomodoroMode.longBreak:
        return const Color(0xFF2196F3); // Blue accent
    }
  }

  String get description {
    switch (this) {
      case PomodoroMode.focus:
        return 'STAY FOCUSED';
      case PomodoroMode.shortBreak:
        return 'SHORT BREAK';
      case PomodoroMode.longBreak:
        return 'LONG BREAK';
    }
  }
}
