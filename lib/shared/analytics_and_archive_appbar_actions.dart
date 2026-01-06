import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/sales_provider.dart';
import 'package:myapp/shared/ui_helpers.dart';
import 'package:myapp/pages/notification_page.dart';

List<Widget> buildAppBarActions(
  BuildContext context, {
  String tooltip = "Download",
}) {
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
      icon: const Icon(Icons.download, color: Color(0xFF0A6305)),
      tooltip: tooltip,
      onPressed: () => downloadReport(context, context.read<SalesProvider>()),
    ),
  ];
}
