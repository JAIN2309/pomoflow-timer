import 'dart:async';
import 'package:flutter/material.dart';
import '../models/pomodoro_mode.dart';

class PomodoroViewModel extends ChangeNotifier {
  Timer? _timer;
  PomodoroMode _currentMode = PomodoroMode.focus;
  
  // Custom user durations
  int _focusDurationMinutes = PomodoroMode.focus.defaultMinutes;
  int _shortBreakDurationMinutes = PomodoroMode.shortBreak.defaultMinutes;
  int _longBreakDurationMinutes = PomodoroMode.longBreak.defaultMinutes;

  late int _secondsRemaining;
  late int _totalDurationSeconds;
  bool _isRunning = false;

  // Callback hook when a session completes
  VoidCallback? onSessionCompleted;

  PomodoroViewModel() {
    _totalDurationSeconds = _currentMode.defaultMinutes * 60;
    _secondsRemaining = _totalDurationSeconds;
  }

  PomodoroMode get currentMode => _currentMode;
  int get secondsRemaining => _secondsRemaining;
  int get totalDurationSeconds => _totalDurationSeconds;
  bool get isRunning => _isRunning;
  double get progress => _totalDurationSeconds > 0 ? _secondsRemaining / _totalDurationSeconds : 0.0;

  int get focusDurationMinutes => _focusDurationMinutes;
  int get shortBreakDurationMinutes => _shortBreakDurationMinutes;
  int get longBreakDurationMinutes => _longBreakDurationMinutes;

  int getDurationMinutesForMode(PomodoroMode mode) {
    switch (mode) {
      case PomodoroMode.focus:
        return _focusDurationMinutes;
      case PomodoroMode.shortBreak:
        return _shortBreakDurationMinutes;
      case PomodoroMode.longBreak:
        return _longBreakDurationMinutes;
    }
  }

  void updateDuration(PomodoroMode mode, int minutes) {
    if (minutes < 1 || minutes > 120) return; // Sane limits: 1 to 120 minutes
    switch (mode) {
      case PomodoroMode.focus:
        _focusDurationMinutes = minutes;
        break;
      case PomodoroMode.shortBreak:
        _shortBreakDurationMinutes = minutes;
        break;
      case PomodoroMode.longBreak:
        _longBreakDurationMinutes = minutes;
        break;
    }

    if (_currentMode == mode) {
      _totalDurationSeconds = minutes * 60;
      if (!_isRunning) {
        _secondsRemaining = _totalDurationSeconds;
      } else {
        _secondsRemaining = _secondsRemaining.clamp(0, _totalDurationSeconds);
      }
    }
    notifyListeners();
  }

  void startTimer() {
    _timer?.cancel();
    _isRunning = true;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        _onTimerComplete();
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    _isRunning = false;
    notifyListeners();
  }

  void resetTimer() {
    _timer?.cancel();
    _isRunning = false;
    _totalDurationSeconds = getDurationMinutesForMode(_currentMode) * 60;
    _secondsRemaining = _totalDurationSeconds;
    notifyListeners();
  }

  void switchMode(PomodoroMode mode) {
    _timer?.cancel();
    _currentMode = mode;
    _isRunning = false;
    _totalDurationSeconds = getDurationMinutesForMode(mode) * 60;
    _secondsRemaining = _totalDurationSeconds;
    notifyListeners();
  }

  void skipSession() {
    final nextMode = _currentMode == PomodoroMode.focus
        ? PomodoroMode.shortBreak
        : PomodoroMode.focus;
    switchMode(nextMode);
  }

  void _onTimerComplete() {
    _timer?.cancel();
    _isRunning = false;
    _secondsRemaining = 0;
    notifyListeners();
    onSessionCompleted?.call();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
