import 'package:flutter/material.dart';
import 'package:myapp/analytics-widgets/performance_overview_section.dart';
import 'package:myapp/analytics-widgets/variation_insights_section.dart';
import 'package:myapp/pages/sections/appbar_section.dart';
import 'package:myapp/shared/side_menu_item.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, int> weeklySales = {
      "Mon": 1000,
      "Tue": 2500,
      "Wed": 1800,
      "Thu": 3000,
      "Fri": 2000,
      "Sat": 500,
      "Sun": 0,
    };

    final variationSales = <String, int>{
      "Latundan": 3500,
      "Lakatan": 4200,
      "Cardava": 1800,
      "Other": 500,
    };

    return Scaffold(
      appBar: appBar(
        leadingIcon: CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFFE0E0E0),
          child: Icon(Icons.bar_chart, color: Color(0xFF0A6305)),
        ),
        title: "Analytics",
        subtitle: "Insights and performance",
      ),
      endDrawer: SideMenu(
        title: "Analytics Menu",
        items: [
          SideMenuItem(
            label: "Filter by Date",
            icon: Icons.date_range,
            onTap: () {
              // show date picker
            },
          ),
          SideMenuItem(
            label: "Change Chart Type",
            icon: Icons.bar_chart,
            onTap: () {
              // switch chart type
            },
          ),
          SideMenuItem(
            label: "Export Report",
            icon: Icons.download,
            onTap: () {
              // export analytics report
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          PerformanceOverviewSection(weeklySales: weeklySales),
          const SizedBox(height: 24),
          VariationInsightsSection(variationSales: variationSales),
        ],
      ),
    );
  }
}
