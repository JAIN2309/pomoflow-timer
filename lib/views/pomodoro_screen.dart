import 'package:flutter/material.dart';
import '../models/pomodoro_mode.dart';
import '../viewmodels/pomodoro_viewmodel.dart';
import 'widgets/completion_dialog.dart';
import 'widgets/control_buttons.dart';
import 'widgets/mode_selector.dart';
import 'widgets/settings_panel.dart';
import 'widgets/timer_ring.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  late final PomodoroViewModel _viewModel;
  bool _showSettings = false;

  @override
  void initState() {
    super.initState();
    _viewModel = PomodoroViewModel();
    _viewModel.onSessionCompleted = _handleSessionCompleted;
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _handleSessionCompleted() {
    final nextMode = _viewModel.currentMode == PomodoroMode.focus
        ? PomodoroMode.shortBreak
        : PomodoroMode.focus;

    CompletionDialog.show(
      context: context,
      currentMode: _viewModel.currentMode,
      onStartNext: () {
        _viewModel.switchMode(nextMode);
        _viewModel.startTimer();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        final accentColor = _viewModel.currentMode.accentColor;

        return Scaffold(
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E2C),
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.4,
                colors: [
                  accentColor.withValues(alpha: 0.08),
                  const Color(0xFF1E1E2C),
                ],
                stops: const [0.0, 1.0],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 48), // spacer for balance
                            const Row(
                              children: [
                                Icon(
                                  Icons.timer_outlined,
                                  color: Colors.white54,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'POMOFLOW',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 4.0,
                                    color: Colors.white54,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _showSettings = !_showSettings;
                                });
                              },
                              icon: Icon(
                                _showSettings ? Icons.close_rounded : Icons.settings_rounded,
                                color: _showSettings ? accentColor : Colors.white54,
                              ),
                              tooltip: 'Configure Session Durations',
                            ),
                          ],
                        ),
                        const Spacer(),
                        ModeSelector(
                          currentMode: _viewModel.currentMode,
                          onModeSelected: _viewModel.switchMode,
                        ),
                        const Spacer(),
                        if (_showSettings) ...[
                          SettingsPanel(
                            focusMinutes: _viewModel.focusDurationMinutes,
                            shortBreakMinutes: _viewModel.shortBreakDurationMinutes,
                            longBreakMinutes: _viewModel.longBreakDurationMinutes,
                            onFocusMinutesChanged: (val) => _viewModel.updateDuration(PomodoroMode.focus, val),
                            onShortBreakMinutesChanged: (val) => _viewModel.updateDuration(PomodoroMode.shortBreak, val),
                            onLongBreakMinutesChanged: (val) => _viewModel.updateDuration(PomodoroMode.longBreak, val),
                          ),
                          const Spacer(),
                        ],
                        TimerRing(
                          secondsRemaining: _viewModel.secondsRemaining,
                          progress: _viewModel.progress,
                          accentColor: accentColor,
                          description: _viewModel.currentMode.description,
                        ),
                        const Spacer(),
                        ControlButtons(
                          isRunning: _viewModel.isRunning,
                          accentColor: accentColor,
                          onPlayPause: () {
                            if (_viewModel.isRunning) {
                              _viewModel.pauseTimer();
                            } else {
                              _viewModel.startTimer();
                            }
                          },
                          onReset: _viewModel.resetTimer,
                          onSkip: _viewModel.skipSession,
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
