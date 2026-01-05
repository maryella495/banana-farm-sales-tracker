import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/archive-widgets/variation_utils.dart';
import 'package:myapp/providers/sales_provider.dart';

class FilterDialog extends StatelessWidget {
  final String? selectedVariety;
  final ValueChanged<String?> onVarietySelected;
  final ValueChanged<DateTimeRange?> onDateRangeSelected;
  final VoidCallback onClear;

  const FilterDialog({
    super.key,
    required this.selectedVariety,
    required this.onVarietySelected,
    required this.onDateRangeSelected,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Filter Sales"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Variety section header
          const ListTile(
            leading: Icon(Icons.local_offer, color: Color(0xFF0A6305)),
            title: Text(
              "By Variety",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          // Variety options
          ...["Lakatan", "Latundan", "Cardava", "Other"].map((variation) {
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
              trailing: selectedVariety == variation
                  ? const Icon(Icons.check, color: Color(0xFF0A6305))
                  : null,
              onTap: () {
                onVarietySelected(variation);
                Navigator.pop(context);
              },
            );
          }),

          const Divider(),

          // Date filter option
          ListTile(
            leading: const Icon(Icons.date_range, color: Color(0xFF0A6305)),
            title: const Text("By Date Range"),
            onTap: () async {
              final picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                initialDateRange:
                    context.read<SalesProvider>().filterRange ??
                    DateTimeRange(
                      start: DateTime.now().subtract(const Duration(days: 7)),
                      end: DateTime.now(),
                    ),
              );
              onDateRangeSelected(picked);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0A6305),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          onPressed: () {
            onClear();
            Navigator.pop(context);
          },
          child: const Text("Clear Filter"),
        ),
      ],
    );
  }
}
