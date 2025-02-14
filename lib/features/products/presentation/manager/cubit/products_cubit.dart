
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/features/categories/data/data_source/categories_data_source.dart';
import 'package:shops_manager_offline/features/products/data/models/product_model.dart';
import 'package:shops_manager_offline/features/products/data/repo/product_repo.dart';
import 'package:shops_manager_offline/features/warehouses/data/data_sources/warehouses_data_source.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo _productsRepo = ProductsRepo();
  List<ProductModel> _allProducts = []; // Store all products
  int? _selectedWarehouseId; // Track the selected warehouse ID
  int? _selectedCategoryId; // Track the selected category ID

  ProductsCubit() : super(ProductsInitial());

  // Getters for selected warehouse and category IDs
  int? get selectedWarehouseId => _selectedWarehouseId;
  int? get selectedCategoryId => _selectedCategoryId;

  // Fetch all products
  Future<void> fetchAllProducts() async {
    emit(ProductsLoading());
    try {
      final result = await _productsRepo.fetchAllProducts();
      result.fold(
        (failure) => emit(ProductsFailure(failure.errMessage)),
        (products) async {
          _allProducts = products;
          emit(ProductsSuccess(products));
        },
      );
    } catch (e) {
      emit(ProductsFailure('An unexpected error occurred: $e'));
    }
  }

  Future<void> fetchProductById({required int productId}) async {
    emit(ProductsLoading());
    try {
      final result = await _productsRepo.getProductByID(productID: productId);
      result.fold(
        (failure) => emit(ProductsFailure(failure.errMessage)),
        (product) async {
          final ProductModel editedPorduct =
              await getProductWareHouseNameAndWarehouse(product);
          emit(PrdocutDetailsLoadingSuccess(editedPorduct));
        },
      );
    } catch (e) {
      emit(ProductsFailure('An unexpected error occurred: $e'));
    }
  }

  // Set the selected warehouse ID
  void setSelectedWarehouseId(int? warehouseId) {
    _selectedWarehouseId = warehouseId;
    _selectedCategoryId = null; // Reset category when warehouse changes
    emit(ProductsSuccess(_allProducts)); // Rebuild the UI
  }

  // Set the selected category ID
  void setSelectedCategoryId(int? categoryId) {
    _selectedCategoryId = categoryId;
    emit(ProductsSuccess(_allProducts)); // Rebuild the UI
  }

  // Filter products by warehouse and category
  List<ProductModel> getFilteredProducts() {
    if (_selectedWarehouseId == null && _selectedCategoryId == null) {
      return _allProducts; // No filters applied
    } else if (_selectedWarehouseId != null && _selectedCategoryId == null) {
      // Filter by warehouse only
      return _allProducts
          .where((product) => product.warehouseId == _selectedWarehouseId)
          .toList();
    } else if (_selectedWarehouseId != null && _selectedCategoryId != null) {
      // Filter by warehouse and category
      return _allProducts
          .where((product) =>
              product.warehouseId == _selectedWarehouseId &&
              product.categoryId == _selectedCategoryId)
          .toList();
    } else {
      return []; // Invalid filter combination
    }
  }

  // Add a new product
  Future<void> addProduct(ProductModel product) async {
    emit(ProductsLoading());
    try {
      final ProductModel modifiedProduct =
          await getProductWareHouseNameAndWarehouse(product);
      final result = await _productsRepo.addProduct(modifiedProduct);

      result.fold(
        (failure) => emit(ProductsFailure(failure.errMessage)),
        (_) => fetchAllProducts(), // Refresh the list after adding
      );
    } catch (e) {
      emit(ProductsFailure('Failed to add product: $e'));
    }
  }

  // Update an existing product
  Future<void> updateProduct(ProductModel product) async {
    emit(ProductsLoading());
    try {
      final result = await _productsRepo.updateProduct(product);
      result.fold(
        (failure) => emit(ProductsFailure(failure.errMessage)),
        (_) => fetchAllProducts(), // Refresh the list after updating
      );
    } catch (e) {
      emit(ProductsFailure('Failed to update product: $e'));
    }
  }

  // Delete a product
  Future<void> deleteProduct(int id) async {
    emit(ProductsLoading());
    try {
      final result = await _productsRepo.deleteProduct(id);
      result.fold(
        (failure) => emit(ProductsFailure(failure.errMessage)),
        (_) => fetchAllProducts(), // Refresh the list after deleting
      );
    } catch (e) {
      emit(ProductsFailure('Failed to delete product: $e'));
    }
  }

  Future<List<ProductModel>> mapIdToCategoryNameAndWareHouseName(
      List<ProductModel> products) async {
    List<ProductModel> listWithCategories = products;
    for (var product in listWithCategories) {
      final categoryName =
          await CategoriesDataSource().getCategroyNameById(product.categoryId);
      product.categoryName = categoryName;
    }
    for (var product in listWithCategories) {
      final warehouseName =
          await WarehouseDataSource().getWarehosueById(product.warehouseId);
      product.warehouseName = warehouseName;
    }
    return listWithCategories;
  }

  Future<ProductModel> getProductWareHouseNameAndWarehouse(
      ProductModel product) async {
    ProductModel editedProduct = product;
    final categoryName =
        await CategoriesDataSource().getCategroyNameById(product.categoryId);
    editedProduct.categoryName = categoryName;
    final warehouseName =
        await WarehouseDataSource().getWarehosueById(product.warehouseId);
    editedProduct.warehouseName = warehouseName;
    return editedProduct;
  }
}
