import 'package:flutter/material.dart';
import 'settings_item.dart';

class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          SettingsItem(
            icon: Icons.person,
            title: "Account",
            subtitle: "Manage your profile",
            onTap: () {},
          ),
          const Divider(height: 1),
          SettingsItem(
            icon: Icons.notifications,
            title: "Notifications",
            subtitle: "Configure alerts",
            onTap: () {},
          ),
          const Divider(height: 1),
          SettingsItem(
            icon: Icons.lock,
            title: "Privacy",
            subtitle: "Security settings",
            onTap: () {},
          ),
          const Divider(height: 1),
          SettingsItem(
            icon: Icons.help_outline,
            title: "Help & Support",
            subtitle: "Get assistance",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
