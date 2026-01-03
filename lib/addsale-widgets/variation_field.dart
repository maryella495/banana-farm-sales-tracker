import 'package:flutter/material.dart';

class VariationField extends StatelessWidget {
  final String? selectedVariation;
  final String? customVariation;
  final List<String> variations;
  final ValueChanged<String?> onChanged;
  final ValueChanged<String>? onCustomChanged;

  const VariationField({
    super.key,
    required this.selectedVariation,
    required this.customVariation,
    required this.variations,
    required this.onChanged,
    this.onCustomChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.eco, size: 18, color: Color(0xFF0A6305)),
            SizedBox(width: 6),
            Text(
              "Banana Variation *",
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
          child: DropdownButtonFormField<String>(
            value: selectedVariation,
            hint: const Text(
              "Select banana variation",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            decoration: const InputDecoration(border: InputBorder.none),
            items: [
              ...variations.map(
                (v) => DropdownMenuItem(value: v, child: Text(v)),
              ),
              const DropdownMenuItem(value: "Other", child: Text("Other")),
            ],
            onChanged: onChanged,
            validator: (value) => value == null ? "Required" : null,
          ),
        ),
        if (selectedVariation == "Other") ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: _boxDecoration,
            child: TextFormField(
              decoration: _inputDecoration("Enter new variation"),
              onChanged: onCustomChanged,
              validator: (value) =>
                  value == null || value.isEmpty ? "Required" : null,
            ),
          ),
        ],
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
