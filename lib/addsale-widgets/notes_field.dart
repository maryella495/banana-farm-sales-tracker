import 'package:flutter/material.dart';

class NotesField extends StatelessWidget {
  final TextEditingController controller;
  const NotesField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.description, size: 18, color: Color(0xFF0A6305)),
            SizedBox(width: 6),
            Text(
              "Notes (optional)",
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
            maxLines: 3,
            decoration: _inputDecoration("Add any additional notes..."),
            validator: (value) => null, // optional, no validation
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
