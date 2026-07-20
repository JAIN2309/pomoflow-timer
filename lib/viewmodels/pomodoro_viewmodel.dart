import 'dart:async';
import 'package:flutter/material.dart';
import '../models/pomodoro_mode.dart';

class PomodoroViewModel extends ChangeNotifier {
  Timer? _timer;
  PomodoroMode _currentMode = PomodoroMode.focus;
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
    _secondsRemaining = _totalDurationSeconds;
    notifyListeners();
  }

  void switchMode(PomodoroMode mode) {
    _timer?.cancel();
    _currentMode = mode;
    _isRunning = false;
    _totalDurationSeconds = mode.defaultMinutes * 60;
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
