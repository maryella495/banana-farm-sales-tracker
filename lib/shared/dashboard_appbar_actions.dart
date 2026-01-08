import 'package:flutter/material.dart';
import 'package:myapp/providers/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:myapp/pages/notification_page.dart';
import 'package:myapp/providers/sales_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

List<Widget> buildDashboardActions(
  BuildContext context, {
  bool? isUploadDisabled,
}) {
  return [
    // Notifications
    IconButton(
      icon: const Icon(Icons.notifications, color: Color(0xFF0A6305)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NotificationPage()),
        );
      },
    ),

    // Upload
    IconButton(
      icon: const Icon(Icons.upload, color: Color(0xFF0A6305)),
      tooltip: "Upload sales data",
      onPressed: () async {
        final provider = context.read<SalesProvider>();
        final messenger = ScaffoldMessenger.of(context);
        final notifier = context.read<NotificationProvider>();

        final result = await FilePicker.platform.pickFiles();
        if (result != null) {
          final file = File(result.files.single.path!);
          final csvData = await file.readAsString();

          await provider.importSalesFromCsv(csvData);

          messenger.showSnackBar(
            const SnackBar(content: Text("Sales imported successfully!")),
          );

          notifier.addNotification(
            "Imported ${provider.sales.length} sales from CSV",
          );
        }
      },
    ),
  ];
}
