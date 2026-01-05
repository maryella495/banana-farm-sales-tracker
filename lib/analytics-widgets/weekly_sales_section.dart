import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/sales_provider.dart';

class WeeklySalesSection extends StatelessWidget {
  final Map<String, double> salesData;

  const WeeklySalesSection({super.key, required this.salesData});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SalesProvider>();

    if (salesData.isEmpty) {
      return Container(
        height: 120,
        alignment: Alignment.center,
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
        child: const Text(
          "No sales data available",
          style: TextStyle(color: Colors.black54),
        ),
      );
    }

    final maxValue = salesData.values.reduce((a, b) => a > b ? a : b);

    return Container(
      height: 260,
      padding: const EdgeInsets.all(12),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${provider.filterLabel} Sales", // dynamic title
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          Expanded(
            child: salesData.length <= 7
                ? Row(
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
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black54,
                              ),
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
                  )
                : LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true), // grid lines
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              if (index < 0 || index >= salesData.keys.length) {
                                return const SizedBox.shrink();
                              }
                              return Text(
                                salesData.keys.elementAt(index),
                                style: const TextStyle(fontSize: 10),
                              );
                            },
                          ),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: salesData.entries
                              .toList()
                              .asMap()
                              .entries
                              .map(
                                (e) => FlSpot(e.key.toDouble(), e.value.value),
                              )
                              .toList(),
                          isCurved: true, // smooth curve
                          color: const Color(0xFF0A6305),
                          barWidth: 3,
                          dotData: FlDotData(show: false),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
