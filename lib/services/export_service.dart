import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:myapp/models/sale.dart';

class ExportService {
  // Existing method: raw sales list
  static Future<File> exportSalesToCsv(List<Sale> sales) async {
    final headers = [
      "Date",
      "Variety",
      "Quantity (kg)",
      "Price/kg",
      "Buyer",
      "Total",
    ];
    final rows = <List<String>>[];

    for (final sale in sales) {
      final total = (sale.price * sale.quantity).toStringAsFixed(2);
      rows.add([
        sale.date.toLocal().toString().split(' ')[0],
        sale.variety,
        sale.quantity.toString(),
        sale.price.toString(),
        sale.buyer,
        total,
      ]);
    }

    final csvData = StringBuffer();
    csvData.writeln(headers.join(","));
    for (final row in rows) {
      csvData.writeln(row.join(","));
    }

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/sales_report.csv";
    final file = File(path);
    return file.writeAsString(csvData.toString(), encoding: utf8);
  }

  // NEW method: grouped analytics (date or variety)
  static Future<File> exportGroupedToCsv(
    Map<String, double> groupedData, {
    String filename = "analytics_report.csv",
  }) async {
    final csvData = StringBuffer();
    csvData.writeln("Group,Total");

    groupedData.forEach((key, value) {
      csvData.writeln("$key,${value.toStringAsFixed(2)}");
    });

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/$filename";
    final file = File(path);
    return file.writeAsString(csvData.toString(), encoding: utf8);
  }
}
