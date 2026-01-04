import 'package:flutter/material.dart';
import 'package:myapp/pages/notification_page.dart';
import 'package:myapp/pages/sections/appbar_section.dart';
import 'package:myapp/settings-widgets/settings_group.dart';
import 'package:myapp/settings-widgets/sign_out_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        leadingIcon: const CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFFE0E0E0),
          child: Icon(Icons.settings, color: Color(0xFF0A6305)),
        ),
        title: "Settings",
        subtitle: "Manage your preferences",
        actions: [
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
            icon: const Icon(Icons.help_outline, color: Color(0xFF0A6305)),
            onPressed: () {
              // show help/about dialog
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SettingsGroup(),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 8),
          SignOutButton(
            onSignOut: () {
              //TODO: handle sign out
            },
          ),
        ],
      ),
    );
  }
}
