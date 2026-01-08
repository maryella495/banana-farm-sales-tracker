import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/sale.dart';
import 'package:myapp/providers/sales_provider.dart';
import 'sale_card.dart';

/// SalesListSection
/// ----------------
/// Displays a scrollable list of sales records with buyer, variety, quantity,
/// and price. Used in ArchivePage to show filtered or full sales history.
///
/// Key features:
/// - Farmer-friendly formatting (e.g., "4 kg | Lakatan")
/// - Responsive layout with spacing and semantic colors
/// - Supports tapping a sale to view details

class SalesListSection extends StatefulWidget {
  final List<Sale> sales;
  final void Function(Sale sale) onDelete;
  final Color Function(String) getVariationColor;
  final void Function(Sale sale)? onTap;
  final bool filtersActive;
  final void Function()? onClearAllFilters;

  const SalesListSection({
    super.key,
    required this.sales,
    required this.onDelete,
    required this.getVariationColor,
    this.onTap,
    this.filtersActive = false,
    this.onClearAllFilters,
  });

  @override
  State<SalesListSection> createState() => _SalesListSectionState();
}

class _SalesListSectionState extends State<SalesListSection> {
  static const int _pageSize = 20; // how many items per page
  int _currentMax = 20;

  @override
  Widget build(BuildContext context) {
    // Guard: show empty state if no sales
    if (widget.sales.isEmpty) {
      final provider = context.watch<SalesProvider>();
      final filtersActive =
          provider.filterRange != null ||
          (ModalRoute.of(context)?.settings.arguments as Map?)?['searchQuery']
                  ?.isNotEmpty ==
              true ||
          (ModalRoute.of(context)?.settings.arguments
                  as Map?)?['selectedVariety'] !=
              null;

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inbox, size: 48, color: Colors.grey),
            const SizedBox(height: 8),
            Text(
              filtersActive ? "No sales match your filters" : "No sales yet",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            if (widget.filtersActive && widget.onClearAllFilters != null)
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0A6305),
                  side: const BorderSide(color: Color(0xFF0A6305)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: widget.onClearAllFilters,
                child: const Text(
                  "Clear filters",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
      );
    }

    final displayedSales = widget.sales.take(_currentMax).toList();

    // Build list of sales cards
    return ListView.builder(
      itemCount: displayedSales.length + 1, // +1 for "Load more" button
      itemBuilder: (context, index) {
        if (index < displayedSales.length) {
          final sale = displayedSales[index];
          return SaleCard(
            sale: sale,
            onDelete: sale.id != null ? widget.onDelete : null,
            getVariationColor: widget.getVariationColor,
            onTap: sale.id != null ? widget.onTap : null,
          );
        } else {
          // Load more button
          final hasMore = _currentMax < widget.sales.length;
          return hasMore
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A6305),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _currentMax = (_currentMax + _pageSize).clamp(
                            0,
                            widget.sales.length,
                          );
                        });
                      },
                      child: const Text("Load more"),
                    ),
                  ),
                )
              : const SizedBox.shrink();
        }
      },
    );
  }
}
