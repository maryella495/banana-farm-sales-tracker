import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:myapp/models/sale.dart';

class ExportService {
  static Future<File> exportSalesToCsv(List<Sale> sales) async {
    // Build CSV header
    final headers = [
      "Date",
      "Variety",
      "Quantity (kg)",
      "Price/kg",
      "Buyer",
      "Total",
    ];
    final rows = <List<String>>[];

    // Add each sale row
    for (final sale in sales) {
      final total = (sale.price * sale.quantity).toStringAsFixed(2);
      rows.add([
        sale.date?.toLocal().toString().split(' ')[0] ?? "",
        sale.variety ?? "",
        sale.quantity.toString(),
        sale.price.toString(),
        sale.buyer ?? "",
        total,
      ]);
    }

    // Combine header + rows
    final csvData = StringBuffer();
    csvData.writeln(headers.join(","));
    for (final row in rows) {
      csvData.writeln(row.join(","));
    }

    // Save to device storage
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/sales_report.csv";
    final file = File(path);
    return file.writeAsString(csvData.toString(), encoding: utf8);
  }
}
