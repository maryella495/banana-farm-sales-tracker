import 'package:flutter/material.dart';
import 'package:myapp/archive-widgets/active_filters_bar_section.dart';
import 'package:myapp/archive-widgets/filter_dialog_section.dart';
import 'package:myapp/shared/analytics_and_archive_appbar_actions.dart';
import 'package:provider/provider.dart';
import 'package:myapp/archive-widgets/sales_count_section.dart';
import 'package:myapp/archive-widgets/sales_list_section.dart';
import 'package:myapp/archive-widgets/searchbar_section.dart';
import 'package:myapp/archive-widgets/variation_utils.dart';
import 'package:myapp/pages/sales_details_page.dart';
import 'package:myapp/pages/sections/appbar_section.dart';
import 'package:myapp/providers/sales_provider.dart';
import 'package:myapp/models/sale.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({super.key});

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedVariety;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {})); // re-render on search
  }

  void _deleteSale(Sale sale) {
    context.read<SalesProvider>().deleteSale(sale.id);
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (_) => FilterDialog(
        selectedVariety: _selectedVariety,
        onVarietySelected: (v) => setState(() => _selectedVariety = v),
        onDateRangeSelected: (range) {
          if (range != null) {
            context.read<SalesProvider>().setFilterRange(range);
          }
        },
        onClear: () {
          context.read<SalesProvider>().clearFilter();
          setState(() {
            _selectedVariety = null;
            _searchController.clear();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SalesProvider>();
    final dateFiltered = provider.sales;

    // Layer local filters: search and variety
    final query = _searchController.text.trim().toLowerCase();
    final displayedSales = dateFiltered.where((sale) {
      final buyer = sale.buyer.toLowerCase();
      final variety = sale.variety.toLowerCase();
      final matchesSearch = query.isEmpty || buyer.contains(query);
      final matchesVariety =
          _selectedVariety == null ||
          variety == _selectedVariety!.toLowerCase();
      return matchesSearch && matchesVariety;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: appBar(
        leadingIcon: const CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFFE0E0E0),
          child: Icon(Icons.archive, color: Color(0xFF0A6305)),
        ),
        title: "Sales Archive",
        subtitle: "Sales history records",
        actions: buildAppBarActions(context, tooltip: "Download report"),
      ),
      body: Column(
        children: [
          SearchBarSection(controller: _searchController),

          ActiveFiltersBar(
            selectedVariety: _selectedVariety,
            searchQuery: query,
            onClearVariety: () => setState(() => _selectedVariety = null),
            onClearSearch: () => setState(() => _searchController.clear()),
          ),

          SalesCountSection(
            count: displayedSales.length,
            onFilterTap: _showFilterDialog,
            displayedSales: displayedSales,
          ),

          Expanded(
            child: SalesListSection(
              sales: displayedSales,
              onDelete: _deleteSale,
              getVariationColor: getVariationColor,
              onTap: (sale) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SaleDetailsPage(saleId: sale.id),
                  ),
                );
              },
              filtersActive:
                  query.isNotEmpty ||
                  _selectedVariety != null ||
                  provider.filterRange != null,
              onClearAllFilters: () {
                context.read<SalesProvider>().clearFilter(); // date
                setState(() {
                  _selectedVariety = null; // variety
                  _searchController.clear(); // search
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
