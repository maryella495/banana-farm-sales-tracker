import 'package:flutter/material.dart';

Color getVariationColor(String? variety) {
  if (variety == null || variety.isEmpty) return Colors.grey;
  switch (variety.toLowerCase()) {
    case "lakatan":
      return Colors.green;
    case "latundan":
      return Colors.yellow.shade700;
    case "cardava":
      return Colors.red;
    default:
      return Colors.purple;
  }
}
