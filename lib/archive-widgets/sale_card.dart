import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/sale.dart';

class SaleCard extends StatelessWidget {
  final Sale sale;
  final void Function(Sale sale) onDelete;
  final Color Function(String) getVariationColor;
  final void Function(Sale sale)? onTap;

  const SaleCard({
    super.key,
    required this.sale,
    required this.onDelete,
    required this.getVariationColor,
    this.onTap,
  });

  static const TextStyle _greyTextStyle = TextStyle(
    fontSize: 13,
    color: Colors.grey,
  );

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(symbol: "₱");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          if (onTap != null) onTap!(sale);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Buyer + date + total
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFFBCDABB),
                    child: Icon(Icons.person, color: Color(0xFF0A6305)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sale.buyer,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.date_range,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${sale.date.toLocal()}".split(' ')[0],
                            style: _greyTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    currency.format(sale.price * sale.quantity),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A6305),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Weight + Price per kilo
              Row(
                children: [
                  const Icon(Icons.balance, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text("${sale.quantity} kg", style: _greyTextStyle),
                  const SizedBox(width: 6),
                  const Text("•", style: _greyTextStyle),
                  const SizedBox(width: 6),
                  Text("₱${sale.price}/kg", style: _greyTextStyle),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              // Variation badge + delete
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCF5DC),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: getVariationColor(sale.variety),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(sale.variety),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
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

                      if (confirm == true) {
                        onDelete(sale);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color(0xFF0A6305),
                            content: Text(
                              "Sale deleted successfully",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.delete_outline, color: Color(0xFFB60D15)),
                        SizedBox(width: 4),
                        Text(
                          "Delete",
                          style: TextStyle(color: Color(0xFFB60D15)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
