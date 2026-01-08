import 'package:flutter/material.dart';
import 'package:myapp/pages/notification_page.dart';
import 'package:myapp/providers/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/sales_provider.dart';
import 'package:myapp/shared/ui_helpers.dart';

List<Widget> buildAppBarActions(
  BuildContext context, {
  String tooltip = "Download",
  bool isDisabled = false,
}) {
  return [
    // Notifications button
    IconButton(
      icon: const Icon(Icons.notifications, color: Color(0xFF0A6305)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NotificationPage()),
        );
      },
    ),

    // Download button
    IconButton(
      icon: Icon(
        Icons.download,
        color: isDisabled ? Colors.grey : const Color(0xFF0A6305),
      ),
      tooltip: tooltip,
      onPressed: isDisabled
          ? null
          : () {
              downloadReport(context, context.read<SalesProvider>());
              context.read<NotificationProvider>().addNotification(
                "Report exported successfully",
              );
            },
    ),
  ];
}
