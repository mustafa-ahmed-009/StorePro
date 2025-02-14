class ProductModel {
  final int? id;
  final String name;
  final int warehouseId;
  final int categoryId;
  final String barcode;
  final double traderPrice;
  final double customerPrice;
  final int wareHouseQuantity;
  int billQuantity;
  final String? color;
  final int criticalQuantity;
  String? categoryName; // Add category name
  String? warehouseName; // Add warehouse name
  final int soldQuantity; // Add sold quantity
  final String size; // Add size field

  ProductModel({
    required this.wareHouseQuantity,
    required this.traderPrice,
    required this.customerPrice,
    required this.barcode,
    this.id,
    this.billQuantity = 1,
    required this.name,
    required this.warehouseId,
    required this.categoryId,
    this.color,
    required this.criticalQuantity,
    this.categoryName, // Initialize category name
    this.warehouseName, // Initialize warehouse name
    this.soldQuantity = 0, // Initialize sold quantity
  required  this.size, // Initialize size
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      billQuantity: map["bill_quantity"],
      wareHouseQuantity: map["quantity"],
      traderPrice: map["traderPrice"],
      customerPrice: map["customerPrice"],
      id: map['id'],
      barcode: map["barcode"],
      name: map['name'],
      warehouseId: map['warehouse_id'],
      categoryId: map['category_id'],
      color: map['color'],
      criticalQuantity: map['critical_quantity'],
      categoryName: map['category_name'],
      warehouseName: map['warehouse_name'],
      soldQuantity: map['sold_quantity'],
      size: map['size'], // Map size from database
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'bill_quantity': billQuantity,
      'name': name,
      'warehouse_id': warehouseId,
      'category_id': categoryId,
      'barcode': barcode,
      'traderPrice': traderPrice,
      'customerPrice': customerPrice,
      'quantity': wareHouseQuantity,
      'color': color,
      'critical_quantity': criticalQuantity,
      'category_name': categoryName, // Include category name
      'warehouse_name': warehouseName, // Include warehouse name
      'sold_quantity': soldQuantity, // Include sold quantity
      'size': size, // Include size
    };
  }

  ProductModel copyWith({
    int? id,
    String? name,
    int? warehouseId,
    int? categoryId,
    String? barcode,
    double? traderPrice,
    double? customerPrice,
    int? wareHouseQuantity,
    int? billQuantity,
    String? color,
    int? criticalQuantity,
    String? categoryName, // Include category name
    String? warehouseName, // Include warehouse name
    int? soldQuantity, // Include sold quantity
    String? size, // Include size
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      warehouseId: warehouseId ?? this.warehouseId,
      categoryId: categoryId ?? this.categoryId,
      barcode: barcode ?? this.barcode,
      traderPrice: traderPrice ?? this.traderPrice,
      customerPrice: customerPrice ?? this.customerPrice,
      wareHouseQuantity: wareHouseQuantity ?? this.wareHouseQuantity,
      billQuantity: billQuantity ?? this.billQuantity,
      color: color ?? this.color,
      criticalQuantity: criticalQuantity ?? this.criticalQuantity,
      categoryName: categoryName ?? this.categoryName, // Handle category name
      warehouseName:
          warehouseName ?? this.warehouseName, // Handle warehouse name
      soldQuantity: soldQuantity ?? this.soldQuantity, // Handle sold quantity
      size: size ?? this.size, // Handle size
    );
  }
}