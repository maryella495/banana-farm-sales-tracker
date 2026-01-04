import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:myapp/analytics-widgets/weekly_sales_section.dart';
import 'package:myapp/analytics-widgets/summary_card.dart';
import 'package:myapp/analytics-widgets/detailed_summary_card.dart';
import 'package:myapp/providers/sales_provider.dart';
import 'package:myapp/models/sale.dart';

class PerformanceOverviewSection extends StatelessWidget {
  final Map<String, int> weeklySales;

  const PerformanceOverviewSection({super.key, required this.weeklySales});

  @override
  Widget build(BuildContext context) {
    final sales = context.watch<SalesProvider>().sales;

    // Average price/kg
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
              Icon(Icons.bar_chart_outlined, color: Color(0xFF0A6305)),
              SizedBox(width: 8),
              Text(
                "Weekly Sales",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          WeeklySalesSection(weeklySales: weeklySales),
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
              name: highestSale.buyer,
              date: DateFormat("MMM d").format(highestSale.date),
              variation: highestSale.variety,
              value:
                  "₱${(highestSale.price * highestSale.quantity).toStringAsFixed(0)}",
              valueColor: const Color(0xFF0A6305),
            ),
          if (lowestSale != null)
            DetailedSummaryCard(
              icon: Icons.trending_down,
              iconColor: const Color(0xFFE6A10C),
              label: "Lowest Sale",
              name: lowestSale.buyer,
              date: DateFormat("MMM d").format(lowestSale.date),
              variation: lowestSale.variety,
              value:
                  "₱${(lowestSale.price * lowestSale.quantity).toStringAsFixed(0)}",
              valueColor: const Color(0xFFE6A10C),
            ),
        ],
      ),
    );
  }
}
