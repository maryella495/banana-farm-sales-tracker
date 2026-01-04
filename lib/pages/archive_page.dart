import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/archive-widgets/sales_count_section.dart';
import 'package:myapp/archive-widgets/sales_list_section.dart';
import 'package:myapp/archive-widgets/searchbar_section.dart';
import 'package:myapp/archive-widgets/variation_utils.dart';
import 'package:myapp/pages/notification_page.dart';
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
  List<Sale> filteredSales = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterSales);
  }

  void _filterSales() {
    final query = _searchController.text.toLowerCase();
    final allSales = context.read<SalesProvider>().sales;
    setState(() {
      filteredSales = allSales
          .where((sale) => sale.buyer.toLowerCase().contains(query))
          .toList();
    });
  }

  void _deleteSale(Sale sale) {
    context.read<SalesProvider>().deleteSale(sale.id);
    _filterSales(); // refresh filtered list
  }

  void _showFilterDialog(List<Sale> allSales) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Filter by Variety"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ["Lakatan", "Latundan", "Cardava", "Other"].map((
              variation,
            ) {
              return ListTile(
                leading: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: getVariationColor(variation),
                    shape: BoxShape.circle,
                  ),
                ),
                title: Text(variation),
                onTap: () {
                  setState(() {
                    filteredSales = allSales
                        .where(
                          (sale) =>
                              sale.variety.toLowerCase() ==
                              variation.toLowerCase(),
                        )
                        .toList();
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  filteredSales = allSales; // reset filter
                });
                Navigator.pop(context);
              },
              child: const Text("Clear Filter"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final allSales = context.watch<SalesProvider>().sales;
    if (filteredSales.isEmpty && _searchController.text.isEmpty) {
      filteredSales = allSales;
    }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Color(0xFF0A6305)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.download, color: Color(0xFF0A6305)),
            tooltip: "Download report",
            onPressed: null, // implement export later
          ),
        ],
      ),
      body: Column(
        children: [
          SearchBarSection(controller: _searchController),
          SalesCountSection(
            count: filteredSales.length,
            onFilterTap: () => _showFilterDialog(allSales),
          ),
          Expanded(
            child: SalesListSection(
              sales: filteredSales,
              onDelete: _deleteSale,
              getVariationColor: getVariationColor,
              onTap: (sale) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SaleDetailsPage(sale: sale),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
