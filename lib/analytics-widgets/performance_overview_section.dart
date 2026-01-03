import 'package:flutter/material.dart';
import 'package:myapp/analytics-widgets/weekly_sales_section.dart';
import 'package:myapp/analytics-widgets/summary_card.dart';
import 'package:myapp/analytics-widgets/detailed_summary_card.dart';

class PerformanceOverviewSection extends StatelessWidget {
  final Map<String, int> weeklySales;

  const PerformanceOverviewSection({super.key, required this.weeklySales});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            children: [
              Icon(Icons.bar_chart_outlined, color: const Color(0xFF0A6305)),
              const SizedBox(width: 8),
              const Text(
                "Weekly Sales",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          WeeklySalesSection(weeklySales: weeklySales),
          const SizedBox(height: 16),
          SummaryCard(label: "Average Price per Kilo", value: "₱45"),
          DetailedSummaryCard(
            icon: Icons.trending_up,
            iconColor: const Color(0xFF0A6305), // ✅ semantic color
            label: "Highest Sale",
            name: "Pedro Garcia",
            date: "Dec 10",
            variation: "Lakatan",
            value: "₱2,000",
            valueColor: Color(0xFF0A6305),
          ),
          DetailedSummaryCard(
            icon: Icons.trending_down,
            iconColor: const Color(0xFFE6A10C), // ✅ semantic color
            label: "Lowest Sale",
            name: "Ana Reyes",
            date: "Dec 12",
            variation: "Cardava",
            value: "₱200",
            valueColor: Color(0xFFE6A10C),
          ),
        ],
      ),
    );
  }
}
