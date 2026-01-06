import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/models/sale.dart';
import 'package:myapp/utils/analytics_helper.dart';

void main() {
  group('AnalyticsHelper', () {
    final sales = [
      Sale(
        id: 1,
        buyer: 'Alice',
        date: DateTime(2025, 1, 1),
        variety: 'Lakatan',
        price: 50,
        quantity: 2,
      ),
      Sale(
        id: 2,
        buyer: 'Bob',
        date: DateTime(2025, 1, 1),
        variety: 'Latundan',
        price: 30,
        quantity: 3,
      ),
      Sale(
        id: 3,
        buyer: 'Charlie',
        date: DateTime(2025, 2, 1),
        variety: 'Lakatan',
        price: 40,
        quantity: 1,
      ),
    ];

    test('groupByDate groups sales by month', () {
      final result = AnalyticsHelper.groupByDate(sales, 'month');
      expect(result['Jan 2025'], 50 * 2 + 30 * 3); // 100 + 90 = 190
      expect(result['Feb 2025'], 40 * 1); // 40
    });

    test('groupByDate groups sales by day', () {
      final result = AnalyticsHelper.groupByDate(sales, 'day');
      expect(result['Jan 1'], 100 + 90); // 190
      expect(result['Feb 1'], 40); // 40
    });

    test('groupByVariety groups sales by variety', () {
      final result = AnalyticsHelper.groupByVariety(sales);
      expect(result['Lakatan'], 100 + 40); // 140
      expect(result['Latundan'], 90);
    });
  });
}
