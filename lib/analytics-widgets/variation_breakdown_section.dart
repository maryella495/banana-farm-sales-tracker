import 'package:flutter/material.dart';

class VariationBreakdownSection extends StatelessWidget {
  final Map<String, int> variationSales;

  const VariationBreakdownSection({super.key, required this.variationSales});

  @override
  Widget build(BuildContext context) {
    final total = variationSales.values.fold(0, (a, b) => a + b);

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: variationSales.entries.map((entry) {
          final percent = (entry.value / total * 100).toStringAsFixed(1);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const Icon(Icons.circle, color: Color(0xFF0A6305), size: 12),
                const SizedBox(width: 8),
                Text("${entry.key}: ₱${entry.value} (${percent}%)"),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
