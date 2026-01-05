import 'package:flutter/material.dart';
import 'package:myapp/analytics-widgets/filter_bar.dart';
import 'package:myapp/services/export_service.dart';
import 'package:provider/provider.dart';
import 'package:myapp/analytics-widgets/performance_overview_section.dart';
import 'package:myapp/analytics-widgets/variation_insights_section.dart';
import 'package:myapp/pages/notification_page.dart';
import 'package:myapp/pages/sections/appbar_section.dart';
import 'package:myapp/providers/sales_provider.dart';
import 'package:myapp/models/sale.dart';
import 'package:intl/intl.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SalesProvider>();
    final sales = provider.sales;

    // --- Guard: empty state ---
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

    // --- Group sales by date (works for weekly, monthly, custom) ---
    final Map<String, double> salesData = {};
    for (final Sale s in sales) {
      if (s.date == null) continue;
      final key = DateFormat('MMM d').format(s.date!); // e.g. Jan 5
      final amount = (s.price * s.quantity);
      salesData.update(key, (value) => value + amount, ifAbsent: () => amount);
    }

    // --- Group sales by variety ---
    final Map<String, double> variationSales = {};
    for (final Sale s in sales) {
      final variety = s.variety ?? "Unknown";
      final amount = (s.price * s.quantity);
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
            icon: const Icon(Icons.notifications, color: Color(0xFF0A6305)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.download, color: Color(0xFF0A6305)),
            tooltip: "Download report",
            onPressed: () async {
              final provider = context.read<SalesProvider>();
              final file = await ExportService.exportSalesToCsv(provider.sales);

              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color(0xFF0A6305),
                  content: Text("Report exported: ${file.path}"),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const FilterBar(),
          const SizedBox(height: 16),
          PerformanceOverviewSection(salesData: salesData), // ✅ now defined
          const SizedBox(height: 24),
          VariationInsightsSection(variationSales: variationSales),
        ],
      ),
    );
  }
}
