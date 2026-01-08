import 'package:flutter/material.dart';
import 'package:myapp/models/sale.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/sales_provider.dart';
import 'package:myapp/shared/ui_helpers.dart';

class SalesCountSection extends StatelessWidget {
  final int count;
  final VoidCallback onFilterTap;
  final List<Sale> displayedSales;

  const SalesCountSection({
    super.key,
    required this.count,
    required this.onFilterTap,
    required this.displayedSales,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SalesProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$count sale${count == 1 ? '' : 's'} found",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.filter_alt, color: Color(0xFF0A6305)),
                tooltip: "Filter by variety or date",
                onPressed: onFilterTap,
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_forever,
                  color: Color(0xFFB60D15),
                ),
                tooltip: displayedSales.isEmpty
                    ? "No sales to delete"
                    : provider.filterRange == null
                    ? "Delete all sales"
                    : "Delete all filtered sales",
                onPressed: () {
                  if (displayedSales.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.grey,
                        content: Text("No sales to delete"),
                      ),
                    );
                    return;
                  }

                  confirmDeleteAllDialog(context, () {
                    for (final sale in displayedSales) {
                      if (sale.id != null) {
                        provider.deleteSale(sale.id!);
                      }
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xFF0A6305),
                        content: Text(
                          provider.filterRange == null
                              ? "All sales deleted successfully"
                              : "All filtered sales deleted successfully",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
