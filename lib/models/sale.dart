class Sale {
  final int? id; // nullable for new inserts
  final String buyer;
  final DateTime date; // sale date
  final String variety; // e.g. "Lakatan", "Latundan", "Cardava", "Other"
  final int quantity; // in kg
  final double price; // price per kg
  final String? notes; // optional notes

  Sale({
    this.id, // no longer required
    required this.buyer,
    required this.date,
    required this.variety,
    required this.quantity,
    required this.price,
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

  // CopyWith for cleaner updates
  Sale copyWith({
    int? id,
    String? buyer,
    String? variety,
    double? price,
    int? quantity,
    DateTime? date,
    String? notes,
  }) {
    return Sale(
      id: id ?? this.id,
      buyer: buyer ?? this.buyer,
      variety: variety ?? this.variety,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      date: date ?? this.date,
      notes: notes ?? this.notes,
    );
  }

  double get total => price * quantity;

  // Convert Sale to Map (for SQLite insert/update)
  Map<String, dynamic> toMap() {
    final map = {
      'buyer': buyer.isNotEmpty ? buyer : "Unknown Buyer",
      'variety': variety.isNotEmpty ? variety : "Unknown",
      'quantity': quantity,
      'price': price,
      'date': date.toIso8601String(),
      'notes': notes,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Create Sale from Map (for SQLite fetch)
  factory Sale.fromMap(Map<String, dynamic> map) {
    return Sale(
      id: map['id'] as int?,
      buyer: (map['buyer'] ?? "Unknown Buyer") as String,
      variety: (map['variety'] ?? "Unknown") as String,
      quantity: (map['quantity'] ?? 0) as int,
      price: (map['price'] ?? 0.0 as num).toDouble(),
      date: map['date'] != null
          ? DateTime.parse(map['date'] as String)
          : DateTime.now(),
      notes: map['notes'] as String?,
    );
  }

  @override
  String toString() {
    return 'Sale(id: $id, buyer: $buyer, variety: $variety, quantity: $quantity, price: $price, date: $date, notes: $notes)';
  }
}
