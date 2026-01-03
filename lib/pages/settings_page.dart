import 'package:flutter/material.dart';
import 'package:myapp/pages/sections/appbar_section.dart';
import 'package:myapp/settings-widgets/settings_group.dart';
import 'package:myapp/settings-widgets/sign_out_button.dart';
import 'package:myapp/shared/side_menu_item.dart';

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
      ),
      endDrawer: SideMenu(
        title: "Settings Menu",
        items: [
          SideMenuItem(
            label: "Account",
            icon: Icons.person,
            onTap: () {
              // go to Account Settings
            },
          ),
          SideMenuItem(
            label: "Notifications",
            icon: Icons.notifications,
            onTap: () {
              // go to Notification Settings
            },
          ),
          SideMenuItem(
            label: "Help & About",
            icon: Icons.help,
            onTap: () {
              // go to Help & About
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
