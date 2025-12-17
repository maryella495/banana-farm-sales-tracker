import 'package:flutter/material.dart';

class SaleDetailsPage extends StatelessWidget {
  final String name;
  final String date;
  final String amount;
  final String quantity;
  final String pricePerKg;
  final String notes;

  const SaleDetailsPage({
    super.key,
    required this.name,
    required this.date,
    required this.amount,
    required this.quantity,
    required this.pricePerKg,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sale Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Total Earned
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF0A6305),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Total Earned: $amount",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Details
            detailItem("Buyer Name", name),
            detailItem("Date of Sale", date),
            detailItem("Quantity Sold", "$quantity kg"),
            detailItem("Price per kg", "₱$pricePerKg"),
            detailItem("Notes", notes.isNotEmpty ? notes : "—"),

            const SizedBox(height: 80), // space so footer doesn't overlap
          ],
        ),
      ),

      // Fixed footer buttons
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, -2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: handle edit
                },
                icon: const Icon(Icons.edit),
                label: const Text("Edit Sale"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(color: Colors.grey.shade400),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: handle delete
                },
                icon: const Icon(Icons.delete),
                label: const Text("Delete Sale"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB60D15),
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
      ),
    );
  }

  Widget detailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
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
    );
  }
}
