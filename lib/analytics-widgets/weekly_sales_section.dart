import 'package:flutter/material.dart';

class WeeklySalesSection extends StatelessWidget {
  final Map<String, int> weeklySales;

  const WeeklySalesSection({super.key, required this.weeklySales});

  @override
  Widget build(BuildContext context) {
    final maxValue = weeklySales.values.reduce((a, b) => a > b ? a : b);

    return Container(
      height: 220,
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: weeklySales.entries.map((entry) {
          final height = (entry.value / maxValue) * 150;
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: height,
                width: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A6305),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 8),
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
