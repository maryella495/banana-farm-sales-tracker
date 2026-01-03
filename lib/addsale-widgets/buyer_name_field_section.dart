import 'package:flutter/material.dart';

class BuyerNameField extends StatelessWidget {
  final TextEditingController controller;
  const BuyerNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.person, size: 18, color: Color(0xFF0A6305)),
            SizedBox(width: 6),
            Text(
              "Buyer Name *",
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
            decoration: _inputDecoration("Enter buyer's name"),
            validator: (value) =>
                value == null || value.isEmpty ? "Required" : null,
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

InputDecoration _inputDecoration(String hint) => InputDecoration(
  hintText: hint,
  border: InputBorder.none,
  contentPadding: const EdgeInsets.symmetric(vertical: 16),
);
