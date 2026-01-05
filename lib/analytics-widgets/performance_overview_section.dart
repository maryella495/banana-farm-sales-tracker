import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:myapp/analytics-widgets/summary_card.dart';
import 'package:myapp/analytics-widgets/detailed_summary_card.dart';
import 'package:myapp/providers/sales_provider.dart';
import 'package:myapp/models/sale.dart';
import 'package:fl_chart/fl_chart.dart';

class PerformanceOverviewSection extends StatelessWidget {
  final Map<String, double> salesData;

  const PerformanceOverviewSection({super.key, required this.salesData});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SalesProvider>();
    final sales = provider.sales;

    // Totals & averages
    final totalSales = sales.fold<double>(
      0,
      (sum, s) => sum + (s.price * s.quantity),
    );
    final totalWeight = sales.fold<int>(0, (sum, s) => sum + s.quantity);
    final avgPrice = totalWeight == 0 ? 0 : totalSales / totalWeight;

    // Highest & lowest sale
    Sale? highestSale;
    Sale? lowestSale;
    if (sales.isNotEmpty) {
      highestSale = sales.reduce(
        (a, b) => (a.price * a.quantity) > (b.price * b.quantity) ? a : b,
      );
      lowestSale = sales.reduce(
        (a, b) => (a.price * a.quantity) < (b.price * b.quantity) ? a : b,
      );
    }

    // --- Adaptive chart widget ---
    Widget chart;
    if (salesData.length == 1) {
      final entry = salesData.entries.first;
      chart = Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text("₱${entry.value.toStringAsFixed(0)} on ${entry.key}"),
      );
    } else if (salesData.length <= 3) {
      chart = SizedBox(
        height: 200,
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: salesData.entries
                    .toList()
                    .asMap()
                    .entries
                    .map((e) => FlSpot(e.key.toDouble(), e.value.value))
                    .toList(),
                isCurved: false,
                color: const Color(0xFF0A6305),
                dotData: FlDotData(show: true),
              ),
            ],
          ),
        ),
      );
    } else if (salesData.length <= 7) {
      final maxValue = salesData.values.reduce((a, b) => a > b ? a : b);
      chart = SizedBox(
        height: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: salesData.entries.map((entry) {
            final height = maxValue == 0
                ? 0.0
                : (entry.value / maxValue * 150).toDouble();
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "₱${entry.value.toStringAsFixed(0)}",
                    style: const TextStyle(fontSize: 11, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A6305),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    } else {
      chart = SizedBox(
        height: 200,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: salesData.entries
                    .toList()
                    .asMap()
                    .entries
                    .map((e) => FlSpot(e.key.toDouble(), e.value.value))
                    .toList(),
                isCurved: true,
                color: const Color(0xFF0A6305),
                dotData: FlDotData(show: false),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart_outlined, color: Color(0xFF0A6305)),
              const SizedBox(width: 8),
              Text(
                "${provider.filterLabel} Sales", // dynamic title
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          chart,
          const SizedBox(height: 16),

          SummaryCard(
            label: "Average Price per Kilo",
            value: "₱${avgPrice.toStringAsFixed(2)}",
          ),

          if (highestSale != null)
            DetailedSummaryCard(
              icon: Icons.trending_up,
              iconColor: const Color(0xFF0A6305),
              label: "Highest Sale",
              name: highestSale.buyer ?? "Unknown",
              date: highestSale.date != null
                  ? DateFormat("MMM d").format(highestSale.date!)
                  : "-",
              variation: highestSale.variety ?? "Unknown",
              value:
                  "₱${(highestSale.price * highestSale.quantity).toStringAsFixed(0)}",
              valueColor: const Color(0xFF0A6305),
            ),
          if (lowestSale != null)
            DetailedSummaryCard(
              icon: Icons.trending_down,
              iconColor: const Color(0xFFE6A10C),
              label: "Lowest Sale",
              name: lowestSale.buyer ?? "Unknown",
              date: lowestSale.date != null
                  ? DateFormat("MMM d").format(lowestSale.date!)
                  : "-",
              variation: lowestSale.variety ?? "Unknown",
              value:
                  "₱${(lowestSale.price * lowestSale.quantity).toStringAsFixed(0)}",
              valueColor: const Color(0xFFE6A10C),
            ),
        ],
      ),
    );
  }
}
