import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/sales_provider.dart';

class RevenueSection extends StatelessWidget {
  const RevenueSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SalesProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: _RevenueCard(
              label: "This Week",
              amount: provider.weekRevenue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _RevenueCard(
              label: "This Month",
              amount: provider.monthRevenue,
            ),
          ),
        ],
      ),
    );
  }
}

class _RevenueCard extends StatelessWidget {
  final String label;
  final double amount;

  const _RevenueCard({required this.label, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 16,
                color: Color(0xFF0A6305),
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "₱${amount.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
