import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/sale.dart';
import 'package:myapp/utils/analytics_helper.dart';
import 'package:myapp/services/database_service.dart';

/// SalesProvider
/// --------------
/// Manages sales state with filtering, analytics, and persistence.
/// Integrates with DatabaseService for SQLite storage.
/// Provides CRUD operations, filter utilities, and revenue analytics.
class SalesProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  List<Sale> _sales = [];
  DateTimeRange? _filterRange;
  String? _selectedVariety;

  DateTimeRange? get filterRange => _filterRange;
  String? get selectedVariety => _selectedVariety;

  /// Initialize provider and load sales
  SalesProvider() {
    _initProvider();
  }

  Future<void> _initProvider() async {
    await _db.init();
    _sales = await _db.getSales();
    notifyListeners();
  }

  /// Load all sales from database (manual refresh)
  Future<void> loadSales() async {
    await _db.init();
    _sales = await _db.getSales();
    notifyListeners();
  }

  /// Sales list with optional filter applied
  List<Sale> get sales {
    if (_filterRange == null) return List.unmodifiable(_sales);
    return _sales.where((s) {
      final saleDate = DateTime(s.date.year, s.date.month, s.date.day);
      return !saleDate.isBefore(_filterRange!.start) &&
          !saleDate.isAfter(_filterRange!.end);
    }).toList();
  }

  /// Filtered sales convenience getter
  List<Sale> get filteredSales {
    var result = _sales;

    // Variety filter
    if (selectedVariety != null) {
      if (selectedVariety == "Other") {
        result = result
            .where(
              (sale) =>
                  sale.variety != "Lakatan" &&
                  sale.variety != "Latundan" &&
                  sale.variety != "Cardava",
            )
            .toList();
      } else {
        result = result
            .where((sale) => sale.variety == selectedVariety)
            .toList();
      }
    }

    // Date range filter
    if (_filterRange != null) {
      result = result
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

    return result;
  }

  bool get hasSales => _sales.isNotEmpty;
  bool get hasFilteredSales => filteredSales.isNotEmpty;
  bool isDuplicate(Sale sale) {
    return _sales.any(
      (s) =>
          s.variety == sale.variety &&
          s.buyer == sale.buyer &&
          s.date.year == sale.date.year &&
          s.date.month == sale.date.month &&
          s.date.day == sale.date.day &&
          s.quantity == sale.quantity &&
          s.price == sale.price,
    );
  }

  /// Filter controls
  void setFilterRange(DateTimeRange? range) {
    _filterRange = range;
    notifyListeners();
  }

  void clearFilter() {
    _filterRange = null;
    _selectedVariety = null;
    notifyListeners();
  }

  void setVarietyFilter(String? variety) {
    _selectedVariety = variety;
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

  /// CRUD operations with persistence

  /// Add a new sale and return the persisted Sale with its assigned ID
  Future<Sale?> addSale(Sale sale) async {
    await _db.init(); // ✅ ensure DB ready before insert
    final id = await _db.insertSale(sale);
    if (id > 0) {
      final newSale = sale.copyWith(id: id);
      _sales.add(newSale);
      notifyListeners();
      return newSale;
    }
    return null; // insert failed
  }

  /// Update an existing sale
  Future<void> updateSale(Sale sale) async {
    if (sale.id == null) return; // can't update without an ID
    await _db.init();
    final rows = await _db.updateSale(sale);
    if (rows > 0) {
      final idx = _sales.indexWhere((s) => s.id == sale.id);
      if (idx != -1) {
        _sales[idx] = sale;
        notifyListeners();
      }
    }
  }

  /// Delete a sale by id
  Future<void> deleteSale(int id) async {
    await _db.init();
    final rows = await _db.deleteSale(id);
    if (rows > 0) {
      _sales.removeWhere((sale) => sale.id == id);
      notifyListeners();
    }
  }

  Future<void> deleteFilteredSales(DateTimeRange? filterRange) async {
    await _db.init();
    if (filterRange == null) {
      await _db.clearSales(); // delete all
      _sales.clear();
    } else {
      // Delete only filtered sales
      for (final sale in filteredSales) {
        if (sale.id != null) {
          await _db.deleteSale(sale.id!);
        }
      }
      _sales = await _db.getSales();
    }
    notifyListeners();
  }

  /// Analytics
  double get totalRevenue => AnalyticsHelper.totalRevenue(_sales);
  double get weekRevenue => AnalyticsHelper.weekRevenue(_sales);
  double get monthRevenue => AnalyticsHelper.monthRevenue(_sales);

  /// Filter label for UI
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
