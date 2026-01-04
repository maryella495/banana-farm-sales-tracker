import 'package:flutter/foundation.dart';
import 'package:myapp/models/sale.dart';

class SalesProvider extends ChangeNotifier {
  final List<Sale> _sales = [];

  List<Sale> get sales => List.unmodifiable(_sales);

  void addSale(Sale sale) {
    _sales.add(sale);
    notifyListeners();
  }

  void updateSale(Sale sale) {
    final idx = _sales.indexWhere((s) => s.id == sale.id);
    if (idx != -1) {
      _sales[idx] = sale;
      notifyListeners();
    }
  }

  void deleteSale(int id) {
    print("Deleting sale with id: $id");
    _sales.removeWhere((sale) => sale.id == id);
    print("Remaining sales: ${_sales.length}");
    notifyListeners();
  }

  // ✅ Optional analytics helpers
  double get totalRevenue => _sales.fold(0.0, (sum, sale) => sum + sale.total);

  double get weekRevenue {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return _sales
        .where((sale) => sale.date.isAfter(startOfWeek))
        .fold(0.0, (sum, sale) => sum + sale.total);
  }

  double get monthRevenue {
    final now = DateTime.now();
    return _sales
        .where(
          (sale) => sale.date.year == now.year && sale.date.month == now.month,
        )
        .fold(0.0, (sum, sale) => sum + sale.total);
  }
}
