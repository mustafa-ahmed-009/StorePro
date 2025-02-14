import 'package:dartz/dartz.dart';
import 'package:shops_manager_offline/core/config/failures.dart';
import 'package:shops_manager_offline/core/config/sqflite_data_base_failure.dart';
import 'package:shops_manager_offline/features/products/data/data_sources/product_data_source.dart';
import 'package:shops_manager_offline/features/products/data/models/product_model.dart';

class ProductsRepo {
  final ProductsDataSource _dataSource = ProductsDataSource();

  // Fetch all products
  Future<Either<Failure, List<ProductModel>>> fetchAllProducts() async {
    try {
      final result = await _dataSource.getAllProducts();
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  // Fetch products by warehouse and category
  Future<Either<Failure, List<ProductModel>>> fetchProductsByWarehouseAndCategory({
    required int warehouseId,
    required int categoryId,
  }) async {
    try {
      final result = await _dataSource.getProductsByWarehouseAndCategory(
        warehouseId: warehouseId,
        categoryId: categoryId,
      );
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  // Add a new product
  Future<Either<Failure, int>> addProduct(ProductModel product) async {
    try {
      final result = await _dataSource.addProduct(product);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  // Update an existing product
  Future<Either<Failure, int>> updateProduct(ProductModel product) async {
    try {
      final result = await _dataSource.updateProduct(product);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }
    Future<Either<Failure, ProductModel>> getProductByID({required int productID}) async {
    try {
      final result = await _dataSource.getProductById(productID);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  // Delete a product
  Future<Either<Failure, int>> deleteProduct(int id) async {
    try {
      final result = await _dataSource.deleteProduct(id);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }
}