import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/analytics-widgets/variation_breakdown_section.dart';
import 'package:myapp/analytics-widgets/detailed_summary_card.dart';
import 'package:myapp/providers/sales_provider.dart';
import 'package:myapp/models/sale.dart';

/// VariationInsightsSection
/// ----------------------------------------------
/// Displays analytics grouped by banana variety.
///  Used in AnalyticsPage to show which varieties contribute most to revenue.
///
/// Key features:
/// - Uses AnalyticsHelper.groupByVariety
/// - Renders a bar chart + summary cards
/// - Helps farmers identify top-performing varieties

class VariationInsightsSection extends StatelessWidget {
  final Map<String, double> variationSales;

  const VariationInsightsSection({super.key, required this.variationSales});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SalesProvider>();
    final sales = context.watch<SalesProvider>().sales;

    // Top selling variation
    MapEntry<String, double>? topVariation;
    if (variationSales.isNotEmpty) {
      topVariation = variationSales.entries.reduce(
        (a, b) => a.value > b.value ? a : b,
      );
    }

    // Highest average price variation
    final Map<String, List<Sale>> grouped = {};
    for (final s in sales) {
      grouped.putIfAbsent(s.variety, () => []).add(s);
    }

    String? highestAvgVariety;
    double highestAvgPrice = 0;
    grouped.forEach((variety, list) {
      final totalQty = list.fold<int>(0, (sum, s) => sum + s.quantity);
      final totalPrice = list.fold<double>(
        0,
        (sum, s) => sum + (s.price * s.quantity),
      );
      final avg = totalQty == 0.0 ? 0.0 : totalPrice / totalQty;
      if (avg > highestAvgPrice) {
        highestAvgPrice = avg;
        highestAvgVariety = variety;
      }
    });

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
            children: const [
              Icon(Icons.pie_chart, color: Color(0xFF0A6305)),
              SizedBox(width: 8),
              Text(
                "Variation Insights",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          VariationBreakdownSection(variationSales: variationSales),
          const SizedBox(height: 16),
          if (topVariation != null)
            DetailedSummaryCard(
              icon: Icons.star,
              iconColor: const Color(0xFF0A6305),
              label: "Top Selling Variation",
              name: topVariation.key,
              date: provider.filterLabel,
              variation: "",
              value: "₱${topVariation.value.toStringAsFixed(0)}",
              valueColor: const Color(0xFF0A6305),
            ),
          if (highestAvgVariety != null)
            DetailedSummaryCard(
              icon: Icons.attach_money,
              iconColor: const Color(0xFFE6A10C),
              label: "Highest Avg Price Variation",
              name: highestAvgVariety!,
              date: provider.filterLabel,
              variation: "",
              value: "₱${highestAvgPrice.toStringAsFixed(2)}/kg",
              valueColor: const Color(0xFFE6A10C),
            ),
        ],
      ),
    );
  }
}
