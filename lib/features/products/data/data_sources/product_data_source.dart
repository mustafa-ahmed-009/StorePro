import 'package:shops_manager_offline/core/config/data_base_helper.dart';
import 'package:shops_manager_offline/features/products/data/models/product_model.dart';

class ProductsDataSource {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Fetch all products
  Future<List<ProductModel>> getAllProducts() async {
    final db = await _dbHelper.database;
    final result = await db.query('products');
    List<ProductModel> products =
        result.map((map) => ProductModel.fromMap(map)).toList();
    return products;
  }

  // Fetch products for a specific warehouse and category
  Future<List<ProductModel>> getProductsByWarehouseAndCategory({
    required int warehouseId,
    required int categoryId,
  }) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'products',
      where: 'warehouse_id = ? AND category_id = ?',
      whereArgs: [warehouseId, categoryId],
    );
    return result.map((map) => ProductModel.fromMap(map)).toList();
  }

  Future<List<ProductModel>> searchProducts(String text) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'products',
      where: 'name LIKE ?',
      whereArgs: ['%$text%'], // Use % to allow partial matches
    );
    return result.map((map) => ProductModel.fromMap(map)).toList();
  }

  Future<ProductModel> getProductById(int id) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'products',
      where: 'id = ?', // Filter by the provided ID
      whereArgs: [id], // Pass the ID as an argument
      limit: 1, // Limit the result to 1 row
    );
    final ProductModel product = ProductModel.fromMap(result.first);

    return product; // Return the first matching product
  }

  // Add a new product
  Future<int> addProduct(ProductModel product) async {
    final db = await _dbHelper.database;
    return await db.insert('products', product.toMap());
  }

  // Update an existing product
  Future<int> updateProduct(ProductModel product) async {
    final db = await _dbHelper.database;
    return await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  // Delete a product
  Future<int> deleteProduct(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }


}
