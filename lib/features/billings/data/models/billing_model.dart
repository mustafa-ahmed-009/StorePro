class BillingModel {
  final int? id;
  final String createdAt;
  final double total;

  BillingModel({
    this.id,
    required this.createdAt,
    required this.total,
  });

  // Factory method to create a BillingModel from a map
  factory BillingModel.fromMap(Map<String, dynamic> map) {
    return BillingModel(
      id: map["id"],
      createdAt: map["created_at"],
      total: map["total"]?.toDouble() ?? 0.0, // Ensure total is a double
    );
  }

  // Convert a BillingModel to a map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id, // Only include id if it's not null
      'created_at': createdAt,
      'total': total,
    };
  }

  // CopyWith method to create a new BillingModel with updated fields
  BillingModel copyWith({
    int? id,
    String? createdAt,
    double? total,
  }) {
    return BillingModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      total: total ?? this.total,
    );
  }
}