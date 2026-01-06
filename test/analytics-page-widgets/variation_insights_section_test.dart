import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/analytics-widgets/variation_breakdown_section.dart';

void main() {
  group('VariationBreakdownSection Widget Tests', () {
    testWidgets('renders with provided variationSales', (
      WidgetTester tester,
    ) async {
      final variationSales = {'Lakatan': 120.0, 'Latundan': 80.0};

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VariationBreakdownSection(variationSales: variationSales),
          ),
        ),
      );

      // Check that the widget renders
      expect(find.byType(VariationBreakdownSection), findsOneWidget);

      // If VariationBreakdownSection uses Text widgets for labels, check them
      expect(find.text('Lakatan'), findsWidgets);
      expect(find.text('Latundan'), findsWidgets);
    });
  });
}
