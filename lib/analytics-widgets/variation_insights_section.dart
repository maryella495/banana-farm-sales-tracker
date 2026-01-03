import 'package:flutter/material.dart';
import 'package:myapp/analytics-widgets/variation_breakdown_section.dart';
import 'package:myapp/analytics-widgets/detailed_summary_card.dart';

class VariationInsightsSection extends StatelessWidget {
  final Map<String, int> variationSales;

  const VariationInsightsSection({super.key, required this.variationSales});

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
          //Section header
          Row(
            children: [
              Icon(Icons.pie_chart, color: const Color(0xFF0A6305)),
              const SizedBox(width: 8),
              const Text(
                "Variation Insights",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          VariationBreakdownSection(variationSales: variationSales),
          const SizedBox(height: 16),
          DetailedSummaryCard(
            icon: Icons.star,
            iconColor: const Color(0xFF0A6305),
            label: "Top Selling Variation",
            name: "Lakatan",
            date: "This week",
            variation: "",
            value: "₱4,200",
            valueColor: const Color(0xFF0A6305),
          ),
          DetailedSummaryCard(
            icon: Icons.attach_money,
            iconColor: const Color(0xFFE6A10C),
            label: "Highest Avg Price Variation",
            name: "Latundan",
            date: "This month",
            variation: "",
            value: "₱55/kg",
            valueColor: const Color(0xFFE6A10C),
          ),
        ],
      ),
    );
  }
}
