class BillModel {
  final int? id;
  final String createdAt;
  final String? customerName;
  final String? phoneNumber;
  final double total;

  BillModel({
    this.id,
    required this.createdAt,
    required this.customerName,
    required this.phoneNumber,
    required this.total,
  });

  // Factory method to create a BillModel from a map
  factory BillModel.fromMap(Map<String, dynamic> map) {
    return BillModel(
      id: map["id"],
      createdAt: map["created_at"], // Corrected key name
      customerName:
          map["customer_name"] == "" ? "غير مسجل" : map["customer_name"],
      phoneNumber: map["phone_number"] == "" ? "غير مسجل" : map["phone_number"],
      total: map["total"]?.toDouble() ?? 0.0, // Ensure total is a double
    );
  }

  // Convert a BillModel to a map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id, // Only include id if it's not null
      'created_at': createdAt,
      'customer_name': customerName,
      'phone_number': phoneNumber,
      'total': total,
    };
  }

  // CopyWith method to create a new BillModel with updated fields
  BillModel copyWith({
    int? id,
    String? createdAt,
    String? customerName,
    String? phoneNumber,
    double? total,
  }) {
    return BillModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      customerName: customerName ?? this.customerName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      total: total ?? this.total,
    );
  }
}
