import 'package:flutter/material.dart';
import 'package:myapp/models/sale.dart';
import 'package:myapp/salesdetails-widgets/edit-sale-section/save_button.dart';
import 'package:myapp/salesdetails-widgets/form_styles.dart';
import 'edit_sale_widgets.dart';

Future<void> showEditSaleDialog(BuildContext context, Sale sale) async {
  final parentContext = context;

  final buyerController = TextEditingController(text: sale.buyer);
  final priceController = TextEditingController(
    text: sale.price % 1 == 0
        ? sale.price.toStringAsFixed(0)
        : sale.price.toStringAsFixed(2),
  );
  final quantityController = TextEditingController(
    text: sale.quantity % 1 == 0
        ? sale.quantity.toStringAsFixed(0)
        : sale.quantity.toStringAsFixed(2),
  );

  final noteController = TextEditingController(text: sale.notes ?? "");

  final variations = ['Lakatan', 'Latundan', 'Cardava', 'Other'];
  String selectedVariation = variations.contains(sale.variety)
      ? sale.variety
      : 'Other';
  final otherVariationController = TextEditingController(
    text: selectedVariation == 'Other' ? sale.variety : '',
  );

  DateTime selectedDate = sale.date;

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: const Color(0xFFE8F5E9),
            title: const Text(
              'Edit Sale',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  BuyerSection(controller: buyerController),
                  SaleDetailsSection(
                    selectedDate: selectedDate,
                    onDateChanged: (d) => setState(() => selectedDate = d),
                    selectedVariation: selectedVariation,
                    variations: variations,
                    onVariationChanged: (v) =>
                        setState(() => selectedVariation = v),
                    otherController: otherVariationController,
                    priceController: priceController,
                    quantityController: quantityController,
                  ),
                  NotesSection(controller: noteController),
                ],
              ),
            ),
            actions: [
              OutlinedButton(
                style: outlinedGreenButtonStyle,
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              SaveButton(
                parentContext: parentContext,
                sale: sale,
                buyerController: buyerController,
                priceController: priceController,
                quantityController: quantityController,
                noteController: noteController,
                selectedVariation: selectedVariation,
                otherVariationController: otherVariationController,
                selectedDate: selectedDate,
              ),
            ],
          );
        },
      );
    },
  );
}
