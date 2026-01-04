import 'package:flutter/material.dart';
import 'package:myapp/salesdetails-widgets/total_earned_section.dart';
import 'package:myapp/salesdetails-widgets/sales_info_section.dart';
import 'package:myapp/salesdetails-widgets/notes_section.dart';
import 'package:myapp/salesdetails-widgets/ed_footer_buttons_section.dart';

class SaleDetailsPage extends StatelessWidget {
  final String name;
  final String date;
  final String variation;
  final String amount;
  final String quantity;
  final String pricePerKg;
  final String notes;

  const SaleDetailsPage({
    super.key,
    required this.name,
    required this.date,
    required this.variation,
    required this.amount,
    required this.quantity,
    required this.pricePerKg,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sale Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TotalEarnedSection(amount: amount),
            const SizedBox(height: 24),
            SalesInfoSection(
              name: name,
              date: date,
              variation: variation,
              quantity: quantity,
              pricePerKg: pricePerKg,
            ),
            const SizedBox(height: 16),
            NotesSection(notes: notes),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: const EDFooterButtons(),
    );
  }
}
