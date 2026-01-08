import 'package:flutter/material.dart';
import 'package:myapp/salesdetails-widgets/edit-sale-section/edit_sale_helpers.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/sale.dart';
import 'package:myapp/providers/sales_provider.dart';
import 'package:myapp/salesdetails-widgets/form_styles.dart';

class SaveButton extends StatelessWidget {
  final BuildContext parentContext;
  final Sale sale;
  final TextEditingController buyerController;
  final TextEditingController priceController;
  final TextEditingController quantityController;
  final TextEditingController noteController;
  final String selectedVariation;
  final TextEditingController otherVariationController;
  final DateTime selectedDate;

  const SaveButton({
    super.key,
    required this.parentContext,
    required this.sale,
    required this.buyerController,
    required this.priceController,
    required this.quantityController,
    required this.noteController,
    required this.selectedVariation,
    required this.otherVariationController,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: greenButtonStyle,
      child: const Text('Save'),
      onPressed: () {
        final validationError = validateSaleInputs(
          buyerController.text.trim(),
          priceController.text.trim(),
          quantityController.text.trim(),
          selectedVariation,
          otherVariationController.text.trim(),
          selectedDate,
        );

        if (validationError != null) {
          ScaffoldMessenger.of(parentContext).hideCurrentSnackBar();
          ScaffoldMessenger.of(
            parentContext,
          ).showSnackBar(buildSnackBar(validationError));
          return;
        }

        final parsedPrice = double.tryParse(priceController.text.trim()) ?? 0.0;
        final parsedQty =
            double.tryParse(quantityController.text.trim()) ?? 0.0;

        final finalVariety = selectedVariation == 'Other'
            ? (otherVariationController.text.trim().isEmpty
                  ? sale.variety
                  : otherVariationController.text.trim())
            : selectedVariation;

        final updatedSale = sale.copyWith(
          buyer: buyerController.text.trim().isEmpty
              ? "Unknown Buyer"
              : buyerController.text.trim(),
          variety: finalVariety,
          price: parsedPrice,
          quantity: parsedQty,
          date: selectedDate,
          notes: noteController.text.trim().isEmpty
              ? null
              : noteController.text.trim(),
        );

        if (updatedSale == sale) {
          ScaffoldMessenger.of(parentContext).hideCurrentSnackBar();
          ScaffoldMessenger.of(
            parentContext,
          ).showSnackBar(buildSnackBar('No changes made'));
          return;
        }

        //  Show Change Preview Confirmation
        final changes = buildChangeSummary(sale, updatedSale);
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
              'Confirm Changes',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(changes),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xFF0A6305)),
                ),
              ),
              ElevatedButton(
                style: greenButtonStyle,
                onPressed: () {
                  Navigator.pop(ctx); // close preview
                  parentContext.read<SalesProvider>().updateSale(updatedSale);

                  // Show success snackbar
                  ScaffoldMessenger.of(parentContext).hideCurrentSnackBar();
                  ScaffoldMessenger.of(parentContext).showSnackBar(
                    buildSuccessSnackBar(
                      'Sale updated successfully for ${updatedSale.buyer}',
                    ),
                  );

                  Navigator.pop(context); // close edit dialog
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
        );
      },
    );
  }
}
