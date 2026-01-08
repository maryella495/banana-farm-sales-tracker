import 'package:flutter/material.dart';
import 'package:myapp/models/sale.dart';

SnackBar buildSnackBar(String message, {SnackBarAction? action}) {
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
    ),
    backgroundColor: Colors.grey[800],
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(12),
    action: action,
  );
}

SnackBar buildSuccessSnackBar(String message) {
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    ),
    backgroundColor: const Color(0xFF0A6305),
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(12),
  );
}

/// Compares old and new Sale objects and returns a summary of changes
String buildChangeSummary(Sale oldSale, Sale newSale) {
  final changes = <String>[];

  if (oldSale.buyer != newSale.buyer) {
    changes.add("Buyer: ${oldSale.buyer} → ${newSale.buyer}");
  }
  if (oldSale.variety != newSale.variety) {
    changes.add("Variety: ${oldSale.variety} → ${newSale.variety}");
  }
  if (oldSale.price != newSale.price) {
    changes.add(
      "Price: ${oldSale.price.toStringAsFixed(2)} → ${newSale.price.toStringAsFixed(2)}",
    );
  }
  if (oldSale.quantity != newSale.quantity) {
    changes.add(
      "Quantity: ${oldSale.quantity.toStringAsFixed(2)} → ${newSale.quantity.toStringAsFixed(2)}",
    );
  }

  if (oldSale.date != newSale.date) {
    changes.add(
      "Date: ${oldSale.date.toLocal().toString().split(' ')[0]} → "
      "${newSale.date.toLocal().toString().split(' ')[0]}",
    );
  }
  if (oldSale.notes != newSale.notes) {
    changes.add("Notes: ${oldSale.notes ?? '-'} → ${newSale.notes ?? '-'}");
  }

  return changes.isEmpty ? "No changes detected." : changes.join("\n");
}

//Validates sale input fields before saving
String? validateSaleInputs(
  String buyer,
  String price,
  String quantity,
  String selectedVariation,
  String otherVariation,
  DateTime selectedDate,
) {
  if (buyer.isEmpty) return "Buyer name cannot be empty";

  final parsedPrice = double.tryParse(price);
  if (parsedPrice == null || parsedPrice <= 0) {
    return "Price must be a positive number";
  }

  final parsedQty = double.tryParse(quantity);
  if (parsedQty == null || parsedQty <= 0) {
    return "Enter a valid quantity (e.g., 2.5)";
  }

  if (selectedVariation == 'Other' && otherVariation.isEmpty) {
    return "Please enter a variety name";
  }

  if (selectedDate.isAfter(DateTime.now())) {
    return "Sale date cannot be in the future";
  }

  return null;
}

Future<DateTime?> showGreenDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) {
  return showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF0A6305),
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Color(0xFF0A6305)),
          ),
        ),
        child: child!,
      );
    },
  );
}
