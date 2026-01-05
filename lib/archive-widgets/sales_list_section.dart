import 'package:flutter/material.dart';
import 'package:myapp/models/sale.dart';
import 'sale_card.dart';

class SalesListSection extends StatefulWidget {
  final List<Sale> sales;
  final void Function(Sale sale) onDelete;
  final Color Function(String) getVariationColor;
  final void Function(Sale sale)? onTap;

  const SalesListSection({
    super.key,
    required this.sales,
    required this.onDelete,
    required this.getVariationColor,
    this.onTap,
  });

  @override
  State<SalesListSection> createState() => _SalesListSectionState();
}

class _SalesListSectionState extends State<SalesListSection> {
  static const int _pageSize = 20; // how many items per page
  int _currentMax = 20;

  @override
  Widget build(BuildContext context) {
    if (widget.sales.isEmpty) {
      return const Center(
        child: Text(
          "No sales found",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    final displayedSales = widget.sales.take(_currentMax).toList();

    return ListView.builder(
      itemCount: displayedSales.length + 1, // +1 for "Load more" button
      itemBuilder: (context, index) {
        if (index < displayedSales.length) {
          final sale = displayedSales[index];
          return SaleCard(
            sale: sale,
            onDelete: widget.onDelete,
            getVariationColor: widget.getVariationColor,
            onTap: widget.onTap,
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
