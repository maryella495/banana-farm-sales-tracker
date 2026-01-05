import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/sales_provider.dart';

class ActiveFiltersBar extends StatelessWidget {
  final String? selectedVariety;
  final String searchQuery;
  final VoidCallback onClearVariety;
  final VoidCallback onClearSearch;

  const ActiveFiltersBar({
    super.key,
    required this.selectedVariety,
    required this.searchQuery,
    required this.onClearVariety,
    required this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SalesProvider>();
    final hasFilters =
        selectedVariety != null ||
        provider.filterRange != null ||
        searchQuery.isNotEmpty;

    if (!hasFilters) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          if (selectedVariety != null)
            Chip(
              label: Text(selectedVariety!),
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFF0A6305)),
              onDeleted: onClearVariety,
            ),
          if (provider.filterRange != null)
            Chip(
              label: Text(
                "${provider.filterRange!.start.toLocal().toString().split(' ')[0]}"
                " to ${provider.filterRange!.end.toLocal().toString().split(' ')[0]}",
              ),
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFF0A6305)),
              onDeleted: () => context.read<SalesProvider>().clearFilter(),
            ),
          if (searchQuery.isNotEmpty)
            Chip(
              label: Text('Buyer: $searchQuery'),
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFF0A6305)),
              onDeleted: onClearSearch,
            ),
        ],
      ),
    );
  }
}
