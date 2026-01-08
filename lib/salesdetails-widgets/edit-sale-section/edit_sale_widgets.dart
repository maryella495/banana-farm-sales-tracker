import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/salesdetails-widgets/form_styles.dart';
import 'package:myapp/salesdetails-widgets/edit-sale-section/edit_sale_helpers.dart'; // 👈 added

class BuyerSection extends StatelessWidget {
  final TextEditingController controller;
  const BuyerSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Buyer Info",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller,
          decoration: styledDecoration('Buyer'),
          autofocus: true,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class SaleDetailsSection extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;
  final String selectedVariation;
  final List<String> variations;
  final ValueChanged<String> onVariationChanged;
  final TextEditingController otherController;
  final TextEditingController priceController;
  final TextEditingController quantityController;

  const SaleDetailsSection({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
    required this.selectedVariation,
    required this.variations,
    required this.onVariationChanged,
    required this.otherController,
    required this.priceController,
    required this.quantityController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDatePicker(context, selectedDate, onDateChanged),
        const SizedBox(height: 16),
        _buildVarietyDropdown(
          selectedVariation,
          variations,
          onVariationChanged,
          otherController,
        ),
        const SizedBox(height: 16),
        _buildPriceQuantityRow(priceController, quantityController),
        const SizedBox(height: 16),
      ],
    );
  }
}

class NotesSection extends StatelessWidget {
  final TextEditingController controller;
  const NotesSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Notes", style: TextStyle(fontSize: 15)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: styledDecoration('Note (optional)'),
          maxLines: 3,
        ),
      ],
    );
  }
}

//  Helper UI builders

Widget _buildDatePicker(
  BuildContext context,
  DateTime selectedDate,
  ValueChanged<DateTime> onDateChanged,
) {
  return InkWell(
    onTap: () async {
      final picked = await showGreenDatePicker(
        context: context,
        initialDate: selectedDate.isAfter(DateTime.now())
            ? DateTime.now()
            : selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
      );
      if (picked != null) onDateChanged(picked);
    },
    child: InputDecorator(
      decoration: styledDecoration('Date'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(selectedDate.toLocal().toString().split(' ')[0]),
          const Icon(Icons.calendar_today, size: 20, color: Color(0xFF0A6305)),
        ],
      ),
    ),
  );
}

Widget _buildVarietyDropdown(
  String selectedVariation,
  List<String> variations,
  ValueChanged<String> onChanged,
  TextEditingController otherController,
) {
  return Column(
    children: [
      DropdownButtonFormField<String>(
        initialValue: selectedVariation,
        items: variations
            .map(
              (v) => DropdownMenuItem(
                value: v,
                child: Text(
                  v,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) onChanged(value);
        },
        decoration: styledDecoration('Variety'),
      ),
      if (selectedVariation == 'Other') ...[
        const SizedBox(height: 12),
        TextField(
          controller: otherController,
          decoration: styledDecoration('Enter variety'),
        ),
      ],
    ],
  );
}

Widget _buildPriceQuantityRow(
  TextEditingController priceController,
  TextEditingController quantityController,
) {
  return Row(
    children: [
      Expanded(
        child: TextField(
          controller: quantityController,
          decoration: styledDecoration('Quantity (kg)'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: TextField(
          controller: priceController,
          decoration: styledDecoration('Price (₱/kg)'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
        ),
      ),
    ],
  );
}
