import 'package:flutter/material.dart';
import 'package:myapp/pages/help_page.dart';
import 'package:myapp/pages/notification_page.dart';
import 'package:myapp/pages/privacy_page.dart';
import 'package:myapp/settings-widgets/settings_item.dart';
import 'package:myapp/shared/appbar_section.dart';
import 'package:myapp/settings-widgets/settings_group.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSection(
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpPage()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SettingsGroup(
            items: [
              SettingsItem(
                icon: Icons.lock,
                title: "Privacy",
                subtitle: "Security settings",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PrivacyPage()),
                  );
                },
              ),
              SettingsItem(
                icon: Icons.help_outline,
                title: "Help & Support",
                subtitle: "Get assistance",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HelpPage()),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
