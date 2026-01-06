import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/sale.dart';

class SalesProvider extends ChangeNotifier {
  final List<Sale> _sales = [];
  DateTimeRange? _filterRange;
  DateTimeRange? get filterRange => _filterRange;

  List<Sale> get sales {
    if (_filterRange == null) return List.unmodifiable(_sales);
    return _sales.where((s) {
      final saleDate = DateTime(s.date.year, s.date.month, s.date.day);
      return !saleDate.isBefore(_filterRange!.start) &&
          !saleDate.isAfter(_filterRange!.end);
    }).toList();
  }

  List<Sale> get filteredSales {
    if (_filterRange == null) return _sales;
    return _sales
        .where(
          (sale) =>
              sale.date.isAfter(
                _filterRange!.start.subtract(const Duration(days: 1)),
              ) &&
              sale.date.isBefore(
                _filterRange!.end.add(const Duration(days: 1)),
              ),
        )
        .toList();
  }

  void setFilterRange(DateTimeRange? range) {
    _filterRange = range;
    notifyListeners();
  }

  void clearFilter() {
    _filterRange = null;
    notifyListeners();
  }

  void filterThisWeek() {
    final now = DateTime.now();
    final startOfWeek = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1)); // Monday midnight
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    setFilterRange(DateTimeRange(start: startOfWeek, end: endOfWeek));
  }

  void filterThisMonth() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);
    setFilterRange(DateTimeRange(start: startOfMonth, end: endOfMonth));
  }

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
    _sales.removeWhere((sale) => sale.id == id);
    notifyListeners();
  }

  void deleteFilteredSales(DateTimeRange? filterRange) {
    if (filterRange == null) {
      _sales.clear(); // delete all
    } else {
      _sales.removeWhere(
        (sale) =>
            sale.date.isAfter(
              filterRange.start.subtract(const Duration(days: 1)),
            ) &&
            sale.date.isBefore(filterRange.end.add(const Duration(days: 1))),
      );
    }
    notifyListeners();
  }

  double get totalRevenue => _sales.fold(0.0, (sum, sale) => sum + sale.total);

  double get weekRevenue {
    final now = DateTime.now();
    final startOfWeek = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1)); // Monday midnight
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    return _sales
        .where((sale) {
          final d = DateTime(sale.date.year, sale.date.month, sale.date.day);
          return !d.isBefore(startOfWeek) && !d.isAfter(endOfWeek);
        })
        .fold(0.0, (sum, sale) => sum + sale.total);
  }

  double get monthRevenue {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);

    return _sales
        .where((sale) {
          final d = DateTime(sale.date.year, sale.date.month, sale.date.day);
          return !d.isBefore(startOfMonth) && !d.isAfter(endOfMonth);
        })
        .fold(0.0, (sum, sale) => sum + sale.total);
  }

  String get filterLabel {
    if (_filterRange == null) return "Overall";

    final start = _filterRange!.start;
    final end = _filterRange!.end;

    final now = DateTime.now();
    final startOfWeek = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    if (start == startOfWeek && end == endOfWeek) return "This week";

    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);
    if (start == startOfMonth && end == endOfMonth) return "This month";

    return "${DateFormat('MMM d').format(start)} - ${DateFormat('MMM d').format(end)}";
  }
}
