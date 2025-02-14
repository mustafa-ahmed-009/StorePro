import 'package:shops_manager_offline/core/functions/date_format.dart';

class BillProductModel {
  final int? id;
  final String createdAt;
  final int billId; // Foreign key to the bills table
  final int productId; // New field: product_id
  final String? name;
  final double total; // Changed from price to total
  final int quantity;
  final String? barcode;

  BillProductModel({
    this.id,
    required this.createdAt,
    required this.billId,
    required this.productId, // Added productId
    required this.name,
    required this.total, // Changed from price to total
    required this.quantity,
    this.barcode,
  });

  // Factory method to create a BillProductModel from a map
  factory BillProductModel.fromMap(Map<String, dynamic> map) {
    return BillProductModel(
      id: map["id"],
      createdAt:
          formatDateInArabic(map["created_at"]), // Parse the datetime string
      billId: map["bill_id"],
      productId: map["product_id"], // Added productId
      name: map["name"] == "" ? "غير مسجل" : map["name"], // Handle empty name
      total: map["total"]?.toDouble() ?? 0.0, // Changed from price to total
      quantity: map["quantity"] ?? 0, // Ensure quantity is an integer
      barcode: map["barcode"] == ""
          ? "غير مسجل"
          : map["barcode"], // Handle empty barcode
    );
  }

  // Convert a BillProductModel to a map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id, // Only include id if it's not null
      'created_at': createdAt, // Convert DateTime to ISO string
      'bill_id': billId,
      'product_id': productId, // Added productId
      'name': name,
      'total': total, // Changed from price to total
      'quantity': quantity,
      'barcode': barcode,
    };
  }

  // CopyWith method to create a new BillProductModel with updated fields
  BillProductModel copyWith({
    int? id,
    String? createdAt,
    int? billId,
    int? productId, // Added productId
    String? name,
    double? total, // Changed from price to total
    int? quantity,
    String? barcode,
  }) {
    return BillProductModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      billId: billId ?? this.billId,
      productId: productId ?? this.productId, // Added productId
      name: name ?? this.name,
      total: total ?? this.total, // Changed from price to total
      quantity: quantity ?? this.quantity,
      barcode: barcode ?? this.barcode,
    );
  }
}
