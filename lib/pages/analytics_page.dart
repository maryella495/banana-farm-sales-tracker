import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/analytics-widgets/performance_overview_section.dart';
import 'package:myapp/analytics-widgets/variation_insights_section.dart';
import 'package:myapp/pages/notification_page.dart';
import 'package:myapp/pages/sections/appbar_section.dart';
import 'package:myapp/providers/sales_provider.dart';
import 'package:myapp/models/sale.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sales = context.watch<SalesProvider>().sales;

    // --- Group sales by weekday ---
    final Map<String, int> weeklySales = {
      "Mon": 0,
      "Tue": 0,
      "Wed": 0,
      "Thu": 0,
      "Fri": 0,
      "Sat": 0,
      "Sun": 0,
    };

    for (final Sale s in sales) {
      final weekday = s.date.weekday; // 1 = Mon, 7 = Sun
      final amount = (s.price * s.quantity).toInt();
      switch (weekday) {
        case DateTime.monday:
          weeklySales["Mon"] = weeklySales["Mon"]! + amount;
          break;
        case DateTime.tuesday:
          weeklySales["Tue"] = weeklySales["Tue"]! + amount;
          break;
        case DateTime.wednesday:
          weeklySales["Wed"] = weeklySales["Wed"]! + amount;
          break;
        case DateTime.thursday:
          weeklySales["Thu"] = weeklySales["Thu"]! + amount;
          break;
        case DateTime.friday:
          weeklySales["Fri"] = weeklySales["Fri"]! + amount;
          break;
        case DateTime.saturday:
          weeklySales["Sat"] = weeklySales["Sat"]! + amount;
          break;
        case DateTime.sunday:
          weeklySales["Sun"] = weeklySales["Sun"]! + amount;
          break;
      }
    }

    // --- Group sales by variety ---
    final Map<String, int> variationSales = {};
    for (final Sale s in sales) {
      final variety = s.variety;
      final amount = (s.price * s.quantity).toInt();
      variationSales[variety] = (variationSales[variety] ?? 0) + amount;
    }

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
            icon: const Icon(Icons.date_range, color: Color(0xFF0A6305)),
            tooltip: "Select date range",
            onPressed: () async {
              final picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2025, 1, 1),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                // TODO: filter analytics data by picked.start and picked.end
              }
            },
          ),
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
            icon: const Icon(Icons.download, color: Color(0xFF0A6305)),
            tooltip: "Download report",
            onPressed: () {
              // TODO: implement download functionality
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
