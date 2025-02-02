// test/widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_and_thrive/main.dart';

void main() {
  testWidgets('Onboarding navigation test', (WidgetTester tester) async {
    // Build the Flow & Thrive app.
    await tester.pumpWidget(FlowAndThriveApp());

    // Verify the onboarding screen is displayed.
    expect(find.text('Welcome to Flow & Thrive'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // Tap the "Get Started" button.
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Verify that HomeScreen is now displayed.
    expect(find.text('Flow & Thrive Dashboard'), findsOneWidget);
  });
}
