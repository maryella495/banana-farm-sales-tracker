import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/models/sale.dart';
import 'package:myapp/providers/sales_provider.dart';

void main() {
  group('SalesProvider revenue calculations', () {
    late SalesProvider provider;

    setUp(() {
      provider = SalesProvider();
    });

    test('calculates weekRevenue correctly including boundaries', () {
      final now = DateTime.now();

      // Start of this week (Monday midnight)
      final monday = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: now.weekday - 1));

      // End of this week (Sunday midnight)
      final sunday = monday.add(const Duration(days: 6));

      // Sale exactly at Monday boundary
      provider.addSale(
        Sale(
          id: 1,
          variety: "Lakatan",
          quantity: 10,
          price: 50,
          buyer: "Alice",
          date: monday,
        ),
      );

      // Sale mid-week (Wednesday)
      provider.addSale(
        Sale(
          id: 2,
          variety: "Latundan",
          quantity: 5,
          price: 40,
          buyer: "Bob",
          date: monday.add(const Duration(days: 2)),
        ),
      );

      // Sale from last week (should not count)
      provider.addSale(
        Sale(
          id: 3,
          variety: "Cardava",
          quantity: 8,
          price: 30,
          buyer: "Charlie",
          date: monday.subtract(const Duration(days: 2)),
        ),
      );

      // Sale exactly at Sunday boundary
      provider.addSale(
        Sale(
          id: 4,
          variety: "Saba",
          quantity: 2,
          price: 100,
          buyer: "Diana",
          date: sunday,
        ),
      );

      // Expected total: Alice (₱500) + Bob (₱200) + Diana (₱200) = ₱900
      expect(provider.weekRevenue, equals(900));
    });

    test('calculates monthRevenue correctly including boundaries', () {
      final now = DateTime.now();

      // Sale inside the month
      provider.addSale(
        Sale(
          id: 5,
          variety: "Lakatan",
          quantity: 12,
          price: 45,
          buyer: "Diana",
          date: DateTime(now.year, now.month, 2),
        ),
      );

      // Sale from last month (should not count)
      provider.addSale(
        Sale(
          id: 6,
          variety: "Latundan",
          quantity: 6,
          price: 35,
          buyer: "Eve",
          date: DateTime(now.year, now.month - 1, 28),
        ),
      );

      // Sale exactly at last day of month
      final endOfMonth = DateTime(now.year, now.month + 1, 0);
      provider.addSale(
        Sale(
          id: 7,
          variety: "Saba",
          quantity: 2,
          price: 200,
          buyer: "Ivy",
          date: endOfMonth,
        ),
      );

      // Expected total: Diana (₱540) + Ivy (₱400) = ₱940
      expect(provider.monthRevenue, equals(940));
    });

    test('calculates totalRevenue correctly', () {
      provider.addSale(
        Sale(
          id: 8,
          variety: "Lakatan",
          quantity: 10,
          price: 50,
          buyer: "Frank",
          date: DateTime.now(),
        ),
      );

      provider.addSale(
        Sale(
          id: 9,
          variety: "Latundan",
          quantity: 5,
          price: 40,
          buyer: "Grace",
          date: DateTime.now().subtract(const Duration(days: 60)),
        ),
      );

      expect(provider.totalRevenue, equals(10 * 50 + 5 * 40)); // ₱700
    });
  });
}
