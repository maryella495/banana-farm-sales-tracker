import 'package:flutter/material.dart';
import 'package:myapp/models/sale.dart';
import 'package:myapp/salesdetails-widgets/ed_footer_buttons_section.dart';
import 'package:myapp/salesdetails-widgets/notes_section.dart';
import 'package:myapp/salesdetails-widgets/sales_info_section.dart';
import 'package:myapp/salesdetails-widgets/total_earned_section.dart';

class SaleDetailsPage extends StatelessWidget {
  final Sale sale;

  const SaleDetailsPage({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sale Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //
            TotalEarnedSection(amount: sale.quantity * sale.price),
            const SizedBox(height: 16),

            //
            SalesInfoSection(
              name: sale.buyer,
              date: sale.date,
              variation: sale.variety,
              quantity: sale.quantity,
              pricePerKg: sale.price,
            ),
            const SizedBox(height: 16),

            //
            NotesSection(notes: sale.notes ?? ""),
          ],
        ),
      ),

      //
      bottomNavigationBar: EDFooterButtons(sale: sale),
    );
  }
}
