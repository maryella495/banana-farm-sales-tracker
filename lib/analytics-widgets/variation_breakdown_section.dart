import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class VariationBreakdownSection extends StatelessWidget {
  final Map<String, double> variationSales;

  const VariationBreakdownSection({super.key, required this.variationSales});

  @override
  Widget build(BuildContext context) {
    final total = variationSales.values.fold(0.0, (a, b) => a + b);
    if (total == 0) {
      return const Center(
        child: Text("No sales data available for the selected period."),
      );
    }

    final Map<String, Color> varietyColors = {
      "Lakatan": Colors.green,
      "Latundan": Colors.yellow,
      "Cardava": Colors.red,
      "Other": Colors.purple,
    };

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: variationSales.entries.map((entry) {
                  final percent = (entry.value / total * 100).toStringAsFixed(
                    1,
                  );
                  final color = varietyColors[entry.key] ?? Colors.grey;

                  return PieChartSectionData(
                    color: color,
                    value: entry.value.toDouble(),
                    title: "${percent}%",
                    radius: 60,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Legend below the chart
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: variationSales.entries.map((entry) {
              final percent = (entry.value / total * 100).toStringAsFixed(1);
              final color = varietyColors[entry.key] ?? Colors.grey;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(Icons.circle, color: color, size: 12),
                    const SizedBox(width: 8),
                    Text(
                      "${entry.key}: ₱${entry.value.toStringAsFixed(0)} (${percent}%)",
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
