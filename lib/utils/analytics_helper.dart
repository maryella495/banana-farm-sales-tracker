import 'package:intl/intl.dart';
import 'package:myapp/models/sale.dart';

class AnalyticsHelper {
  static String formatDateForFilter(DateTime date, String filterLabel) {
    if (filterLabel.contains("month")) {
      return DateFormat('MMM yyyy').format(date);
    }
    return DateFormat('MMM d').format(date);
  }

  static Map<String, double> groupByDate(List<Sale> sales, String filterLabel) {
    final Map<String, double> data = {};
    for (final s in sales) {
      final key = formatDateForFilter(s.date, filterLabel);
      data.update(key, (value) => value + s.total, ifAbsent: () => s.total);
    }
    return data;
  }

  static Map<String, double> groupByVariety(List<Sale> sales) {
    final Map<String, double> data = {};
    for (final s in sales) {
      data[s.variety] = (data[s.variety] ?? 0) + s.total;
    }
    return data;
  }

  static double totalRevenue(List<Sale> sales) =>
      sales.fold(0.0, (sum, sale) => sum + sale.total);

  static double weekRevenue(List<Sale> sales) {
    final now = DateTime.now();
    final startOfWeek = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    return sales
        .where((sale) {
          final d = DateTime(sale.date.year, sale.date.month, sale.date.day);
          return !d.isBefore(startOfWeek) && !d.isAfter(endOfWeek);
        })
        .fold(0.0, (sum, sale) => sum + sale.total);
  }

  static double monthRevenue(List<Sale> sales) {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);

    return sales
        .where((sale) {
          final d = DateTime(sale.date.year, sale.date.month, sale.date.day);
          return !d.isBefore(startOfMonth) && !d.isAfter(endOfMonth);
        })
        .fold(0.0, (sum, sale) => sum + sale.total);
  }

  /// Average price per kilo across all sales
  static double averagePrice(List<Sale> sales) {
    final totalSales = sales.fold<double>(0.0, (sum, s) => sum + s.total);
    final totalWeight = sales.fold<double>(0.0, (sum, s) => sum + s.quantity);
    return totalWeight == 0.0 ? 0.0 : totalSales / totalWeight;
  }

  /// Highest sale (by total value)
  static Sale? highestSale(List<Sale> sales) {
    if (sales.isEmpty) return null;
    return sales.reduce((a, b) => a.total > b.total ? a : b);
  }

  /// Lowest sale (by total value)
  static Sale? lowestSale(List<Sale> sales) {
    if (sales.isEmpty) return null;
    return sales.reduce((a, b) => a.total < b.total ? a : b);
  }
}
