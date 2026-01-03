import 'package:flutter/material.dart';

class SalesInfoSection extends StatelessWidget {
  final String name;
  final String date;
  final String variation; // ✅ new field
  final String quantity;
  final String pricePerKg;

  const SalesInfoSection({
    super.key,
    required this.name,
    required this.date,
    required this.variation, // ✅ required
    required this.quantity,
    required this.pricePerKg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          _detailRow(Icons.person, "Buyer Name", name),
          _divider(),
          _detailRow(Icons.calendar_today, "Date of Sale", date),
          _divider(),
          _detailRow(Icons.local_offer, "Variation", variation), // ✅ new field
          _divider(),
          _detailRow(Icons.balance, "Quantity Sold", "$quantity kg"),
          _divider(),
          _detailRow(Icons.attach_money, "Price per kg", "₱$pricePerKg"),
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: const Color(0xFFBCDABB),
          child: Icon(icon, color: const Color(0xFF0A6305), size: 22),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey.shade300,
      ),
    );
  }
}
