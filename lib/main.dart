import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'views/pomodoro_screen.dart';

void main() {
  runApp(const PomodoroApp());
}

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PomoFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const PomodoroScreen(),
    );
  }
}
