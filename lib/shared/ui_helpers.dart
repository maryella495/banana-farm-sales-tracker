import 'package:flutter/material.dart';
import 'package:myapp/providers/sales_provider.dart';
import 'package:myapp/services/export_service.dart';

Future<void> downloadReport(
  BuildContext context,
  SalesProvider provider,
) async {
  final hasFilters = provider.filterRange != null;
  final salesToExport = hasFilters ? provider.filteredSales : provider.sales;

  final file = await ExportService.exportSalesToCsv(salesToExport);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color(0xFF0A6305),
      content: Text(
        hasFilters
            ? "Filtered report exported: ${file.path.split('/').last}"
            : "Full report exported: ${file.path.split('/').last}",
      ),
      duration: const Duration(seconds: 4),
    ),
  );
}

Future<DateTimeRange?> showGreenDateRangePicker({
  required BuildContext context,
  required DateTime firstDate,
  required DateTime lastDate,
}) {
  return showDateRangePicker(
    context: context,
    firstDate: firstDate,
    lastDate: lastDate,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF0A6305), // green header & highlight
            onPrimary: Colors.white, // text on green
            onSurface: Colors.black, // default text
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Color(0xFF0A6305), // OK / Cancel buttons
            ),
          ),
        ),
        child: child!,
      );
    },
  );
}

Future<void> confirmDeleteAllDialog(
  BuildContext context,
  VoidCallback onConfirm,
) async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text("Confirm Bulk Deletion"),
      content: const Text(
        "Are you sure you want to delete all filtered sales? This action cannot be undone.",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text("Cancel", style: TextStyle(color: Colors.black)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB60D15),
          ),
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text(
            "Delete All",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );

  if (confirm == true) onConfirm();
}
