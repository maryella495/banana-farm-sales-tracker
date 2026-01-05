import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/sales_provider.dart';
import 'package:myapp/dashboard-widgets/revenue_section.dart';
import 'package:myapp/models/sale.dart';

void main() {
  testWidgets(
    'RevenueSection displays week and month totals including boundaries',
    (WidgetTester tester) async {
      final provider = SalesProvider();
      final now = DateTime.now();

      // Start of this week (Monday midnight)
      final monday = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: now.weekday - 1));

      // End of this week (Sunday midnight)
      final sunday = monday.add(const Duration(days: 6));

      // End of this month
      final endOfMonth = DateTime(now.year, now.month + 1, 0);

      // Sale today
      provider.addSale(
        Sale(
          id: 1,
          variety: "Lakatan",
          quantity: 10,
          price: 50,
          buyer: "Alice",
          date: now,
        ),
      );

      // Sale exactly at Monday boundary
      provider.addSale(
        Sale(
          id: 2,
          variety: "Latundan",
          quantity: 2,
          price: 100,
          buyer: "Bob",
          date: monday,
        ),
      );

      // Sale exactly at Sunday boundary
      provider.addSale(
        Sale(
          id: 3,
          variety: "Saba",
          quantity: 1,
          price: 200,
          buyer: "Charlie",
          date: sunday,
        ),
      );

      // Sale exactly at last day of month
      provider.addSale(
        Sale(
          id: 4,
          variety: "Cardava",
          quantity: 3,
          price: 150,
          buyer: "Diana",
          date: endOfMonth,
        ),
      );

      // Sale from last month (should not count)
      provider.addSale(
        Sale(
          id: 5,
          variety: "Latundan",
          quantity: 5,
          price: 40,
          buyer: "Eve",
          date: DateTime(now.year, now.month - 1, 28),
        ),
      );

      // Build the widget tree with provider
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: provider,
          child: const MaterialApp(home: Scaffold(body: RevenueSection())),
        ),
      );

      // Expected totals:
      // WeekRevenue = Alice (₱500) + Bob (₱200) + Charlie (₱200) = ₱900
      // MonthRevenue = WeekRevenue (₱900) + Diana (₱450) = ₱1350
      expect(find.text("₱900.00"), findsOneWidget); // This Week
      expect(find.text("₱1350.00"), findsOneWidget); // This Month
      expect(find.text("This Week"), findsOneWidget);
      expect(find.text("This Month"), findsOneWidget);
    },
  );
}
