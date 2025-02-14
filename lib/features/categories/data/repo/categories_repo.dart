import 'package:dartz/dartz.dart';
import 'package:shops_manager_offline/core/config/failures.dart';
import 'package:shops_manager_offline/core/config/sqflite_data_base_failure.dart';
import 'package:shops_manager_offline/features/categories/data/data_source/categories_data_source.dart';
import 'package:shops_manager_offline/features/categories/data/models/categories_models.dart';
import 'package:shops_manager_offline/features/warehouses/data/data_sources/warehouses_data_source.dart';

class CategoriesRepo {
  final CategoriesDataSource _dataSource = CategoriesDataSource();

  // Fetch all categories
  Future<Either<Failure, List<CategoriesModel>>> fetchCategories() async {
    try {
      final result = await _dataSource.getAllCategories();
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e)); // Handle database errors
    }
  }

  // Fetch categories for a specific warehouse
  Future<Either<Failure, List<CategoriesModel>>> fetchCategoriesByWarehouse(
      {required int warehouseId}) async {
    try {
      final result = await _dataSource.getCategories(warehouseId: warehouseId);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e)); // Handle database errors
    }
  }

  // Add a new category
  Future<Either<Failure, int>> addCategory(CategoriesModel category) async {
    try {
      final result = await _dataSource.addCategory(category);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e)); // Handle database errors
    }
  }

  // Update an existing category
  Future<Either<Failure, int>> updateCategory(CategoriesModel category) async {
    try {
      final result = await _dataSource.updateCategory(category);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e)); // Handle database errors
    }
  }

  // Delete a category
  Future<Either<Failure, int>> deleteCategory(int id) async {
    try {
      final result = await _dataSource.deleteCategory(id);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e)); // Handle database errors
    }
  }

  // Fetch warehouses and categories together
  Future<Either<Failure, Map<String, dynamic>>> fetchWarehousesAndCategories() async {
    try {
      final warehouses = await WarehouseDataSource().getWarehouses();
      final categories = await _dataSource.getAllCategories();
      return right({
        'warehouses': warehouses,
        'categories': categories,
      });
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e)); // Handle database errors
    }
  }


}