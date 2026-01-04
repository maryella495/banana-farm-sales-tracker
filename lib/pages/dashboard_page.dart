import 'package:flutter/material.dart';
import 'package:myapp/dashboard-widgets/dashboard_header_section.dart';
import 'package:myapp/dashboard-widgets/recent_transaction_section.dart';
import 'package:myapp/pages/notification_page.dart';
import 'package:myapp/pages/sections/appbar_section.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Color(0xFF0A6305)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.upload, color: Color(0xFF0A6305)),
            tooltip: "Upload data",
            onPressed: () {
              // Implement upload functionality here
            },
          ),
        ],
      ),
      body: ListView(
        children: const [
          DashboardHeader(),
          SizedBox(height: 120), // spacing so RevenueSection overlaps nicely
          RecentTransactionSection(),
        ],
      ),
    );
  }
}
