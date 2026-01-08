import 'package:flutter/material.dart';
import 'package:myapp/dashboard-widgets/dashboard_header_section.dart';
import 'package:myapp/dashboard-widgets/recent_transaction_section.dart';
import 'package:myapp/shared/appbar_section.dart';
import 'package:myapp/shared/dashboard_appbar_actions.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSection(
        leadingIcon: Image.asset('assets/images/bfst_logo.png', height: 40),
        title: "BananaTrack",
        actions: buildDashboardActions(context),
      ),
      body: ListView(
        children: const [
          DashboardHeader(),
          SizedBox(height: 120),
          RecentTransactionSection(),
        ],
      ),
    );
  }
}
