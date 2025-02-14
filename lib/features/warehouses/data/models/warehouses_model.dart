class WarehouseModel {
  final int? id; // Make id nullable
  final String name;
   int productsCount;

  WarehouseModel({this.id, required this.name , this.productsCount = 0});

  factory WarehouseModel.fromMap(Map<String, dynamic> map) {
    return WarehouseModel(
      id: map['id'],
      name: map['name'],
      productsCount: map['product_count'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id, 
      'name': name,
      'product_count': productsCount,
    };
  }

  // Add the copyWith method
  WarehouseModel copyWith({
    int? id,
    String? name,
    int? productsCount,
  }) {
    return WarehouseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      productsCount: productsCount ?? this.productsCount,
    );
  }
}
