import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/sales_provider.dart';
import 'package:myapp/dashboard-widgets/revenue_section.dart';
import 'package:myapp/models/sale.dart';

void main() {
  testWidgets('RevenueSection displays week and month totals', (
    WidgetTester tester,
  ) async {
    final provider = SalesProvider();

    // Add a sale today
    provider.addSale(
      Sale(
        id: 1,
        variety: "Lakatan",
        quantity: 10,
        price: 50,
        buyer: "Alice",
        date: DateTime.now(),
      ),
    );

    // Build the widget tree with provider
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: const MaterialApp(home: Scaffold(body: RevenueSection())),
      ),
    );

    // Verify that the totals are displayed
    expect(find.textContaining("₱500.00"), findsOneWidget); // 10 * 50
    expect(find.text("This Week"), findsOneWidget);
    expect(find.text("This Month"), findsOneWidget);
  });
}
