// notification_page.dart
import 'package:flutter/material.dart';
import 'package:myapp/pages/root_page.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFF0A6305)),
            tooltip: "Open settings",
            onPressed: () {
              RootPage.navigateTo(4); // switch to Settings tab
              Navigator.pop(context); // close NotificationPage
            },
          ),
        ],
      ),
      body: const Center(child: Text("Notifications content")),
    );
  }
}
