import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/models/sale.dart';

void main() {
  group('Sale Model Tests', () {
    test('calculates total correctly', () {
      final sale = Sale(
        id: 1,
        buyer: 'Alice',
        date: DateTime(2025, 1, 1),
        variety: 'Lakatan',
        price: 50,
        quantity: 2,
      );

      expect(sale.total, 100.0); // 50 * 2
    });

    test('equality works for same id', () {
      final sale1 = Sale(
        id: 1,
        buyer: 'Alice',
        date: DateTime(2025, 1, 1),
        variety: 'Lakatan',
        price: 50,
        quantity: 2,
      );

      final sale2 = Sale(
        id: 1,
        buyer: 'Bob',
        date: DateTime(2025, 1, 2),
        variety: 'Latundan',
        price: 30,
        quantity: 3,
      );

      // This will only pass if Sale overrides == and hashCode based on id
      expect(sale1.id, sale2.id);
      expect(sale1 == sale2, sale1.id == sale2.id); // fallback logic
    });

    test('toString returns readable format', () {
      final sale = Sale(
        id: 1,
        buyer: 'Alice',
        date: DateTime(2025, 1, 1),
        variety: 'Lakatan',
        price: 50,
        quantity: 2,
      );

      final string = sale.toString();
      expect(string, contains('Alice'));
      expect(string, contains('Lakatan'));
      expect(string, contains('100.0')); // total
    });
  });
}
