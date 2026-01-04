import 'package:flutter/material.dart';

class WeeklySalesSection extends StatelessWidget {
  final Map<String, int> weeklySales;

  const WeeklySalesSection({super.key, required this.weeklySales});

  @override
  Widget build(BuildContext context) {
    // Avoid division by zero
    final maxValue = weeklySales.values.isEmpty
        ? 1
        : weeklySales.values.reduce((a, b) => a > b ? a : b);

    return Container(
      height: 240,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: weeklySales.entries.map((entry) {
          final height = maxValue == 0
              ? 0.0
              : (entry.value / maxValue * 150).toDouble();
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Value label above bar
              Text(
                "₱${entry.value}",
                style: const TextStyle(fontSize: 11, color: Colors.black54),
              ),
              const SizedBox(height: 4),
              Container(
                height: height,
                width: 24,
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
          );
        }).toList(),
      ),
    );
  }
}
