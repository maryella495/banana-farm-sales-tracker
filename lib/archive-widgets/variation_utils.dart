import 'package:flutter/material.dart';

Color getVariationColor(String variation) {
  switch (variation.toLowerCase()) {
    case "lakatan":
      return Colors.green;
    case "latundan":
      return Colors.yellow[700]!;
    case "cardava":
      return Colors.red;
    default:
      return Colors.purple;
  }
}
