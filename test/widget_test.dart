import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_focus_flutter_app/main.dart';

void main() {
  testWidgets('Pomodoro timer initial state test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PomodoroApp());

    // Verify that the title POMOFLOW is rendered
    expect(find.text('POMOFLOW'), findsOneWidget);

    // Verify that the initial time is 25:00
    expect(find.text('25:00'), findsOneWidget);

    // Verify that we can find the Focus, Short Break, and Long Break selectors
    expect(find.text('Focus'), findsOneWidget);
    expect(find.text('Short Break'), findsOneWidget);
    expect(find.text('Long Break'), findsOneWidget);

    // Verify play button is present (contains play icon)
    expect(find.byIcon(Icons.play_arrow_rounded), findsOneWidget);
  });
}
