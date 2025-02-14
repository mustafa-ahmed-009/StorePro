
import 'package:shops_manager_offline/core/config/data_base_helper.dart';
import 'package:shops_manager_offline/features/categories/data/models/categories_models.dart';

class CategoriesDataSource {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Fetch categories for a specific warehouse
  Future<List<CategoriesModel>> getCategories(
      {required int warehouseId}) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'Categories',
      where: 'warehouse_id = ?',
      whereArgs: [warehouseId],
    );
    return result.map((map) => CategoriesModel.fromMap(map)).toList();
  }

  // Fetch all categories
  Future<List<CategoriesModel>> getAllCategories() async {
    final db = await _dbHelper.database;
    final result = await db.query('Categories');
    return result.map((map) => CategoriesModel.fromMap(map)).toList();
  }

  // Add a new category
  Future<int> addCategory(CategoriesModel category) async {
    final db = await _dbHelper.database;
    return await db.insert('Categories', category.toMap());
  }

  // Update an existing category
  Future<int> updateCategory(CategoriesModel category) async {
    final db = await _dbHelper.database;
    return await db.update(
      'Categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  // Delete a category
  Future<int> deleteCategory(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'Categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Fetch categories by warehouse ID
  Future<String> getCategroyNameById(int id) async{
        final db = await _dbHelper.database;
    final result = await db.query('Categories',
      where: 'id = ?',
      whereArgs: [id],
    );
   final categroyName =  result[0]["name"] as String;
   return categroyName; 
}
}
