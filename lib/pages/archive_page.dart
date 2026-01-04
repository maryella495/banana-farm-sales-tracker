import 'package:flutter/material.dart';
import 'package:myapp/archive-widgets/sales_count_section.dart';
import 'package:myapp/archive-widgets/sales_list_section.dart';
import 'package:myapp/archive-widgets/searchbar_section.dart';
import 'package:myapp/archive-widgets/variation_utils.dart';
import 'package:myapp/pages/notification_page.dart';
import 'package:myapp/pages/sales_details_page.dart';
import 'package:myapp/pages/sections/appbar_section.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({super.key});

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> allSales = [
    {
      "name": "Maria Cruz",
      "date": "Dec 5, 2025",
      "quantity": "50",
      "pricePerKg": "45",
      "total": "₱2,000",
      "variation": "Lakatan",
    },
    {
      "name": "Pedro Garcia",
      "date": "Dec 5, 2025",
      "quantity": "50",
      "pricePerKg": "45",
      "total": "₱2,000",
      "variation": "Latundan",
    },
  ];

  List<Map<String, String>> filteredSales = [];

  @override
  void initState() {
    super.initState();
    filteredSales = allSales;
    _searchController.addListener(_filterSales);
  }

  void _filterSales() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredSales = allSales
          .where((sale) => sale["name"]!.toLowerCase().contains(query))
          .toList();
    });
  }

  void _deleteSale(int index) {
    setState(() {
      filteredSales.removeAt(index);
    });
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Filter by Variation"),
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
                              sale["variation"]?.toLowerCase() ==
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
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: appBar(
        leadingIcon: CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFFE0E0E0),
          child: Icon(Icons.archive, color: Color(0xFF0A6305)),
        ),
        title: "Sales Archive",
        subtitle: "Sales history records",
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Color(0xFF0A6305)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.download, color: Color(0xFF0A6305)),
            tooltip: "Download report",
            onPressed: null, // Implement download functionality here
          ),
        ],
      ),
      body: Column(
        children: [
          SearchBarSection(controller: _searchController),
          SalesCountSection(
            count: filteredSales.length,
            onFilterTap: _showFilterDialog,
          ),
          SalesListSection(
            sales: filteredSales,
            onDelete: _deleteSale,
            getVariationColor: getVariationColor,
            onTap: (sale) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SaleDetailsPage(
                    name: sale["name"] ?? "",
                    date: sale["date"] ?? "",
                    variation: sale["variation"] ?? "",
                    amount: sale["total"] ?? "",
                    quantity: sale["quantity"] ?? "",
                    pricePerKg: sale["pricePerKg"] ?? "",
                    notes: sale["notes"] ?? "No notes",
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
