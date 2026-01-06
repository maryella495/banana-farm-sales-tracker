import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/analytics-widgets/performance_overview_section.dart';

void main() {
  group('PerformanceOverviewSection Widget Tests', () {
    testWidgets('renders with provided salesData', (WidgetTester tester) async {
      final salesData = {'Jan 2025': 200.0, 'Feb 2025': 150.0};

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PerformanceOverviewSection(salesData: salesData),
          ),
        ),
      );

      // Verify that the section renders labels from salesData
      expect(find.text('Jan 2025'), findsOneWidget);
      expect(find.text('Feb 2025'), findsOneWidget);
    });
  });
}
