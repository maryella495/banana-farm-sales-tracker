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
  SalesProvider();

  Future<void> init() async {
    await _initProvider();
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
      result = result.where((sale) {
        final saleDate = DateTime(
          sale.date.year,
          sale.date.month,
          sale.date.day,
        );

        return !saleDate.isBefore(_filterRange!.start) &&
            !saleDate.isAfter(_filterRange!.end);
      }).toList();
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
    final endOfMonth = DateTime(
      now.year,
      now.month + 1,
      1,
    ).subtract(const Duration(days: 1));
    setFilterRange(DateTimeRange(start: startOfMonth, end: endOfMonth));
  }

  /// CRUD operations with persistence

  /// Add a new sale and return the persisted Sale with its assigned ID
  Future<Sale?> addSale(Sale sale) async {
    await _db.init();
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

  // Export method
  Future<String> exportSalesAsCsv() async {
    final buffer = StringBuffer();
    buffer.writeln("Date,Buyer,Variety,Quantity,Price,Notes");
    for (final sale in _sales) {
      buffer.writeln(
        "${sale.date.toIso8601String()},"
        "${sale.buyer},"
        "${sale.variety},"
        "${sale.quantity},"
        "${sale.price},"
        "${sale.notes ?? ''}",
      );
    }
    return buffer.toString();
  }

  Future<void> importSalesFromCsv(String csvData) async {
    final lines = csvData.split('\n');

    // Skip header row (first line)
    for (var i = 1; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isEmpty) continue;

      final parts = line.split(',');
      if (parts.length < 5) continue;

      try {
        final sale = Sale(
          date: DateTime.parse(parts[0]),
          buyer: parts[1],
          variety: parts[2],
          quantity: double.tryParse(parts[3]) ?? 0,
          price: double.tryParse(parts[4]) ?? 0,
          notes: parts.length > 5 ? parts[5] : null,
        );

        // Prevent duplicates (same date, buyer, variety)
        final exists = _sales.any(
          (s) =>
              s.buyer == sale.buyer &&
              s.variety == sale.variety &&
              s.date.year == sale.date.year &&
              s.date.month == sale.date.month &&
              s.date.day == sale.date.day &&
              s.quantity == sale.quantity &&
              s.price == sale.price,
        );

        if (!exists) {
          final id = await _db.insertSale(sale);
          if (id > 0) {
            _sales.add(sale.copyWith(id: id));
          }
        }
      } catch (e) {
        // Skip invalid rows
        continue;
      }
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
    final endOfMonth = DateTime(
      now.year,
      now.month + 1,
      1,
    ).subtract(const Duration(days: 1));
    if (start == startOfMonth && end == endOfMonth) return "This month";

    return "${DateFormat('MMM d').format(start)} - ${DateFormat('MMM d').format(end)}";
  }
}
