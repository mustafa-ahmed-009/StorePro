class ExpensesModel {
  final int? id;
  final String createdAt;
  final double price;
  final String name;

  ExpensesModel({
    this.id,
    required this.createdAt,
    required this.price,
    required this.name,
  });

  // Factory method to create an ExpensesModel from a map
  factory ExpensesModel.fromMap(Map<String, dynamic> map) {
    return ExpensesModel(
      id: map["id"],
      createdAt: map["created_at"],
      price: map["price"]?.toDouble() ?? 0.0, // Ensure price is a double
      name: map["name"],
    );
  }

  // Convert an ExpensesModel to a map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id, // Only include id if it's not null
      'created_at': createdAt,
      'price': price,
      'name': name,
    };
  }

  // CopyWith method to create a new ExpensesModel with updated fields
  ExpensesModel copyWith({
    int? id,
    String? createdAt,
    double? price,
    String? name,
  }) {
    return ExpensesModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      price: price ?? this.price,
      name: name ?? this.name,
    );
  }
}