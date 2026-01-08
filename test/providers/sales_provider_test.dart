import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/models/sale.dart';
import 'package:myapp/providers/sales_provider.dart';

void main() {
  late SalesProvider provider;

  setUp(() async {
    provider = SalesProvider();
    await provider.loadSales();
  });

  test('Add sale persists and returns new Sale with ID', () async {
    final sale = Sale(
      id: null,
      buyer: "Test Buyer",
      variety: "Lakatan",
      quantity: 2,
      price: 50.0,
      date: DateTime.now(),
      notes: "Unit test insert",
    );

    final newSale = await provider.addSale(sale);

    expect(newSale, isNotNull);
    expect(newSale!.id, isNotNull);
    expect(provider.sales.any((s) => s.id == newSale.id), true);
  });
}
