import 'package:flutter/material.dart';
import 'package:myapp/analytics-widgets/filter_bar.dart';
import 'package:myapp/shared/analytics_and_archive_appbar_actions.dart';
import 'package:myapp/utils/analytics_helper.dart';
import 'package:provider/provider.dart';
import 'package:myapp/analytics-widgets/performance_overview_section.dart';
import 'package:myapp/analytics-widgets/variation_insights_section.dart';
import 'package:myapp/pages/notification_page.dart';
import 'package:myapp/pages/sections/appbar_section.dart';
import 'package:myapp/providers/sales_provider.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SalesProvider>();
    final sales = provider.sales;

    //  Guard: empty state
    if (sales.isEmpty) {
      return Scaffold(
        appBar: appBar(
          leadingIcon: const CircleAvatar(
            radius: 24,
            backgroundColor: Color(0xFFE0E0E0),
            child: Icon(Icons.bar_chart, color: Color(0xFF0A6305)),
          ),
          title: "Analytics",
          subtitle: "Insights and performance",
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
              icon: Icon(Icons.download, color: Colors.grey),
              tooltip: "Download report",
              onPressed: null,
            ),
          ],
        ),
        body: const Center(
          child: Text(
            "No analytics available yet",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    //  Using helper for grouping
    final salesData = AnalyticsHelper.groupByDate(sales, provider.filterLabel);
    final variationSales = AnalyticsHelper.groupByVariety(sales);

    return Scaffold(
      appBar: appBar(
        leadingIcon: const CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFFE0E0E0),
          child: Icon(Icons.bar_chart, color: Color(0xFF0A6305)),
        ),
        title: "Analytics",
        subtitle: "Insights and performance",
        actions: buildAppBarActions(context, tooltip: "Download analytics"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const FilterBar(),
          const SizedBox(height: 16),
          PerformanceOverviewSection(salesData: salesData),
          const SizedBox(height: 24),
          VariationInsightsSection(variationSales: variationSales),
        ],
      ),
    );
  }
}
