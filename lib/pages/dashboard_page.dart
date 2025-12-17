import 'package:flutter/material.dart';
import 'package:myapp/pages/add_sale_page.dart';
import 'package:myapp/pages/sections/appbar_section.dart';
import 'package:myapp/dashboard-widgets/action_buttons_section.dart';
import 'package:myapp/dashboard-widgets/recent_transaction_section.dart';
import 'package:myapp/dashboard-widgets/revenue_section.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: ListView(
        children: [
          RevenueSection(),
          ActionButtonsSection(),
          RecentTransactionSection(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddSalePage()),
          );
        },
        backgroundColor: Color(0xFF0A6305),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
