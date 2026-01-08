import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuantityField extends StatelessWidget {
  final TextEditingController controller;

  const QuantityField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.balance, size: 18, color: Color(0xFF0A6305)),
            SizedBox(width: 6),
            Text(
              "Quantity Sold (kg) *",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: _boxDecoration,
          child: TextFormField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(fontSize: 16),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Enter quantity",
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],

            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a quantity";
              }
              final parsed = double.tryParse(value);
              if (parsed == null) {
                return "Enter a valid number";
              }
              if (parsed <= 0) {
                return "Quantity must be greater than 0";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

final _boxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(12),
  border: Border.all(color: Colors.grey.shade300),
);
