import 'package:flutter/material.dart';

// Reusable input decoration for form fields
InputDecoration styledDecoration(String label) => InputDecoration(
  labelText: label,
  filled: true,
  fillColor: const Color(0xFFF7F7F7),
  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: Color(0xFF0A6305), width: 2),
  ),
);

// Common style for green elevated buttons
final ButtonStyle greenButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: const Color(0xFF0A6305),
  foregroundColor: Colors.white,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
);

// Common style for outlined green buttons
final ButtonStyle outlinedGreenButtonStyle = OutlinedButton.styleFrom(
  foregroundColor: const Color(0xFF0A6305),
  side: const BorderSide(color: Color(0xFF0A6305)),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
);

// Builds a green-themed input decoration
InputDecoration greenInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: Color(0xFF0A6305)),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF0A6305)),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF0A6305), width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
