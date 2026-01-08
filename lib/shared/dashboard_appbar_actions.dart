import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/pages/notification_page.dart';
import 'package:myapp/providers/sales_provider.dart';

List<Widget> buildDashboardActions(
  BuildContext context, {
  bool? isUploadDisabled,
}) {
  final provider = context.watch<SalesProvider>();
  final disabled = isUploadDisabled ?? provider.sales.isEmpty;

  return [
    IconButton(
      icon: const Icon(Icons.notifications, color: Color(0xFF0A6305)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NotificationPage()),
        );
      },
    ),
    IconButton(
      icon: Icon(
        Icons.upload,
        color: disabled ? Colors.grey : const Color(0xFF0A6305),
      ),
      tooltip: "Upload data",
      onPressed: disabled
          ? null
          : () {
              // Example: trigger upload logic
              // You can implement provider.uploadSales() or similar
              debugPrint("Uploading ${provider.sales.length} sales...");
            },
    ),
  ];
}
