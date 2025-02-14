class CategoriesModel {
  final int? id;
  final String name;
  final int warehouseId;

  CategoriesModel({
    this.id,
    required this.name,
    required this.warehouseId,
  });

  // Convert a map (database row) into a CategoriesModel
  factory CategoriesModel.fromMap(Map<String, dynamic> map) {
    return CategoriesModel(
      id: map['id'],
      name: map['name'],
      warehouseId: map['warehouse_id'],
    );
  }

  // Convert a CategoriesModel into a map (for database operations)
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'warehouse_id': warehouseId,
    };
  }

  // Add the copyWith method
  CategoriesModel copyWith({
    int? id,
    String? name,
    int? warehouseId,
  }) {
    return CategoriesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      warehouseId: warehouseId ?? this.warehouseId,
    );
  }
}