import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/pages/root_page.dart';
import 'package:provider/provider.dart';
import 'package:myapp/pages/sales_details_page.dart';
import 'package:myapp/providers/sales_provider.dart';

/// RecentTransactionSection
/// ------------------------
/// Displays a list of the most recent sales transactions in the DashboardPage.
///
/// Purpose:
/// - Gives farmers a quick glance at their latest activity.
/// - Uses SalesProvider.sales to fetch data.
/// - limited to last 5 transactions for readability.

class RecentTransactionSection extends StatelessWidget {
  const RecentTransactionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final sales = context.watch<SalesProvider>().sales;

    final recent = [...sales]..sort((a, b) => b.date.compareTo(a.date));
    final lastFive = recent.take(5).toList();

    final currency = NumberFormat.currency(symbol: "₱");
    final dateFormat = DateFormat('MMM d, yyyy');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "RECENT TRANSACTIONS",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                onTap: () {
                  RootPage.navigateTo(3);
                },
                child: const Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0A6305),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Transaction list
          if (lastFive.isEmpty)
            const Text(
              "No transactions yet",
              style: TextStyle(
                color: Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            ...lastFive.map(
              (sale) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () {
                    if (sale.id != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SaleDetailsPage(saleId: sale.id!),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Sale not yet saved, cannot view details",
                          ),
                        ),
                      );
                    }
                  },

                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0xFFBCDABB),
                          child: const Icon(
                            Icons.person,
                            color: Color(0xFF0A6305),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sale.buyer,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(dateFormat.format(sale.date)),
                            ],
                          ),
                        ),

                        Text(
                          currency.format(sale.price * sale.quantity),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xFF0A6305),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
