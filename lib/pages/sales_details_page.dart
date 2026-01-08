import 'package:flutter/material.dart';
import 'package:myapp/models/sale.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/sales_provider.dart';
import 'package:myapp/salesdetails-widgets/ed_footer_buttons_section.dart';
import 'package:myapp/salesdetails-widgets/notes_section.dart';
import 'package:myapp/salesdetails-widgets/sales_info_section.dart';
import 'package:myapp/salesdetails-widgets/total_earned_section.dart';

class SaleDetailsPage extends StatelessWidget {
  final int saleId;

  const SaleDetailsPage({super.key, required this.saleId});

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesProvider>(
      builder: (context, provider, _) {
        final sale = provider.sales.firstWhere(
          (s) => s.id == saleId,
          orElse: () => Sale(
            id: -1,
            buyer: 'Not found',
            date: DateTime(2000, 1, 1),
            variety: '—',
            price: 0,
            quantity: 0,
          ),
        );

        if (sale.id == -1) {
          return const Center(child: Text('Sale not found'));
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Sale Details",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
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
      },
    );
  }
}
