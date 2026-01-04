class Sale {
  final int id;
  final String buyer; // e.g. "Maria Cruz"
  final String variety; // e.g. "Lakatan", "Latundan", "Cardava", "Other"
  final int quantity; // in kilograms
  final double price; // price per kg
  final DateTime date; // sale date
  final String? notes; // optional notes

  Sale({
    required this.id,
    required this.buyer,
    required this.variety,
    required this.quantity,
    required this.price,
    required this.date,
    this.notes,
  });

  // Convenience: total amount for this sale
  double get total => price * quantity;
}
