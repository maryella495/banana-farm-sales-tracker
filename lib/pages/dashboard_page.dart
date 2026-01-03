import 'package:flutter/material.dart';
import 'package:myapp/dashboard-widgets/dashboard_header_section.dart';
import 'package:myapp/dashboard-widgets/recent_transaction_section.dart';
import 'package:myapp/pages/sections/appbar_section.dart';
import 'package:myapp/pages/settings_page.dart';
import 'package:myapp/shared/side_menu_item.dart';

//HOMEPAGE
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        leadingIcon: Image.asset(
          'assets/images/bfst_logo.png',
          height: 40,
        ), // logo
        title: "BananaTrack",
      ),
      endDrawer: SideMenu(
        title: "Dashboard Menu",
        items: [
          SideMenuItem(
            label: "Notifications",
            icon: Icons.notifications,
            onTap: () {
              /* go to NotificationPage */
            },
          ),
          SideMenuItem(
            label: "Export Summary",
            icon: Icons.download,
            onTap: () {
              /* export summary */
            },
          ),
          SideMenuItem(
            label: "Settings",
            icon: Icons.settings,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),

      body: ListView(
        children: const [
          DashboardHeader(),
          const SizedBox(height: 100),
          //RevenueSection(),
          //ActionButtonsSection(),
          RecentTransactionSection(),
        ],
      ),
    );
  }
}
