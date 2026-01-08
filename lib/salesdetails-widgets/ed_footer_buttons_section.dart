import 'package:flutter/material.dart';
import 'package:myapp/salesdetails-widgets/edit-sale-section/edit_sale_dialog.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/sale.dart';
import 'package:myapp/providers/sales_provider.dart';

class EDFooterButtons extends StatelessWidget {
  final Sale sale;

  const EDFooterButtons({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 34),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => showEditSaleDialog(context, sale),
              icon: const Icon(Icons.edit, color: Colors.black),
              label: const Text(
                "Edit Sale",
                style: TextStyle(color: Colors.black),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Confirm Deletion"),
                    content: const Text(
                      "Are you sure you want to delete this sale? This action cannot be undone.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB60D15),
                        ),
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
                if (!context.mounted) return;
                if (confirm == true) {
                  if (sale.id != null) {
                    context.read<SalesProvider>().deleteSale(sale.id!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Sale deleted successfully",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Color(0xFF0A6305),
                        duration: Duration(seconds: 3),
                      ),
                    );

                    Navigator.pop(context); // close details page
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Sale not yet saved, cannot delete",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Color(0xFFB60D15),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                }
              },
              icon: const Icon(Icons.delete_outline),
              label: const Text("Delete Sale"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB60D15),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
