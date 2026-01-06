class Sale {
  final int id;
  final String buyer;
  final String variety; // e.g. "Lakatan", "Latundan", "Cardava", "Other"
  final int quantity; // in kg
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Sale &&
        other.id == id &&
        other.buyer == buyer &&
        other.variety == variety &&
        other.price == price &&
        other.quantity == quantity &&
        other.date == date &&
        other.notes == notes;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        buyer.hashCode ^
        variety.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        date.hashCode ^
        notes.hashCode;
  }

  /// CopyWith for cleaner updates
  Sale copyWith({
    String? buyer,
    String? variety,
    double? price,
    int? quantity,
    DateTime? date,
    String? notes,
  }) {
    return Sale(
      id: id,
      buyer: buyer ?? this.buyer,
      variety: variety ?? this.variety,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      date: date ?? this.date,
      notes: notes ?? this.notes,
    );
  }

  double get total => price * quantity;
}
