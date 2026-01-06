import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/analytics-widgets/filter_bar.dart';

void main() {
  group('FilterBar Widget Tests', () {
    testWidgets('renders FilterBar', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: FilterBar())),
      );

      // Smoke test: FilterBar renders
      expect(find.byType(FilterBar), findsOneWidget);
    });
  });
}
