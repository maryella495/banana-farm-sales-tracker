import 'package:flutter/material.dart';

class PriceField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PriceField({super.key, required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.attach_money, size: 18, color: Color(0xFF0A6305)),
            SizedBox(width: 6),
            Text(
              "Price per kg (₱) *",
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
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: _boxDecoration,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: _inputDecoration("0"),
            validator: validator,
          ),
        ),
      ],
    );
  }
}

// Shared styles
final _boxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(12),
  border: Border.all(color: Colors.grey.shade300),
);

InputDecoration _inputDecoration(String hint) => InputDecoration(
  hintText: hint,
  border: InputBorder.none,
  contentPadding: const EdgeInsets.symmetric(vertical: 16),
);
