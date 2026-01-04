import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/models/sale.dart';
import 'package:myapp/providers/sales_provider.dart';

void main() {
  group('SalesProvider revenue calculations', () {
    late SalesProvider provider;

    setUp(() {
      provider = SalesProvider();
    });

    test('calculates weekRevenue correctly', () {
      final provider = SalesProvider();
      final now = DateTime.now();

      // Start of this week (Monday)
      final monday = now.subtract(Duration(days: now.weekday - 1));

      // ✅ Sale on Monday
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

      // ✅ Sale on Wednesday
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

      // ❌ Sale from last week (should not count)
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

      expect(provider.weekRevenue, equals(10 * 50 + 5 * 40)); // ₱700
    });

    test('calculates monthRevenue correctly', () {
      final provider = SalesProvider();
      final now = DateTime.now();

      // ✅ Sale guaranteed to be inside the current month
      provider.addSale(
        Sale(
          id: 4,
          variety: "Lakatan",
          quantity: 12,
          price: 45,
          buyer: "Diana",
          date: DateTime(now.year, now.month, 2), // 2nd day of this month
        ),
      );

      // ❌ Sale from last month (should not count)
      provider.addSale(
        Sale(
          id: 5,
          variety: "Latundan",
          quantity: 6,
          price: 35,
          buyer: "Eve",
          date: DateTime(now.year, now.month - 1, 28), // last month
        ),
      );

      // Expect only the first sale to be included
      expect(provider.monthRevenue, equals(12 * 45));
    });

    test('calculates totalRevenue correctly', () {
      provider.addSale(
        Sale(
          id: 6,
          variety: "Lakatan",
          quantity: 10,
          price: 50,
          buyer: "Frank",
          date: DateTime.now(),
        ),
      );

      provider.addSale(
        Sale(
          id: 7,
          variety: "Latundan",
          quantity: 5,
          price: 40,
          buyer: "Grace",
          date: DateTime.now().subtract(const Duration(days: 60)),
        ),
      );

      expect(provider.totalRevenue, equals(10 * 50 + 5 * 40));
    });
  });
}
