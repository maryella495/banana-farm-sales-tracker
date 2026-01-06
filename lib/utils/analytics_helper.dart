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
}
