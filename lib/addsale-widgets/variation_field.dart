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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: _boxDecoration,
          child: DropdownButtonFormField<String>(
            initialValue: selectedVariation,
            hint: Text(
              "Select banana variation",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black.withValues(alpha: 0.8),
              ),
            ),
            decoration: const InputDecoration(border: InputBorder.none),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black.withValues(alpha: 0.8),
              fontWeight: FontWeight.normal,
            ),
            iconEnabledColor: const Color(0xFF0A6305),
            items: variations
                .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                .toList(),
            onChanged: onChanged,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please select a variety";
              }
              return null;
            },
          ),
        ),
        if (selectedVariation == "Other") ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: _boxDecoration,
            child: TextFormField(
              decoration: _inputDecoration("Enter banana variety"),
              onChanged: onCustomChanged,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter a variety name";
                }
                return null;
              },
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
