import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/features/categories/data/models/categories_models.dart';
import 'package:shops_manager_offline/features/categories/data/repo/categories_repo.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepo _categoriesRepo = CategoriesRepo();
  List<CategoriesModel> _allCategories = []; // Store all categories
  int? _selectedWarehouseId; // Track the selected warehouse ID

  CategoriesCubit() : super(CategoriesInitial());

  // Fetch all categories
  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    try {
      final result = await _categoriesRepo.fetchCategories();
      result.fold(
        (failure) => emit(CategoriesFailure(failure.errMessage)),
        (categories) {
          _allCategories = categories; // Store all categories
          emit(CategoriesSuccess(categories));
        },
      );
    } catch (e) {
      emit(CategoriesFailure('An unexpected error occurred: $e'));
    }
  }

  // Set the selected warehouse ID
  void setSelectedWarehouseId(int? warehouseId) {
    _selectedWarehouseId = warehouseId;
    emit(CategoriesSuccess(_allCategories)); // Rebuild the UI
  }

  // Get the selected warehouse ID
  int? get selectedWarehouseId => _selectedWarehouseId;

  // Filter categories by warehouse ID
  void filterCategoriesByWarehouse(int? warehouseId) {
    if (warehouseId == null) {
      emit(CategoriesSuccess(_allCategories)); // Show all categories
    } else {
      final filteredCategories = _allCategories
          .where((category) => category.warehouseId == warehouseId)
          .toList();
      emit(CategoriesSuccess(filteredCategories)); // Show filtered categories
    }
  }

  // Add a new category
  Future<void> addCategory(String name, int warehouseId) async {
    emit(CategoriesLoading());
    try {
      final newCategory = CategoriesModel(name: name, warehouseId: warehouseId);
      final result = await _categoriesRepo.addCategory(newCategory);
      result.fold(
        (failure) => emit(CategoriesFailure(failure.errMessage)),
        (_) => fetchCategories(), // Refresh the list after adding
      );
    } catch (e) {
      emit(CategoriesFailure('Failed to add category: $e'));
    }
  }

  Future<void> deleteCategory(int id) async {
    emit(CategoriesLoading());
    try {
      final result = await _categoriesRepo.deleteCategory(id);
      result.fold(
        (failure) => emit(CategoriesFailure(failure.errMessage)),
        (_) => fetchCategories(), // Refresh the list after deleting
      );
    } catch (e) {
      emit(CategoriesFailure('Failed to delete category: $e'));
    }
  }

  Future<void> updateCategory(CategoriesModel category) async {
    emit(CategoriesLoading());
    try {
      final result = await _categoriesRepo.updateCategory(category);
      result.fold(
        (failure) => emit(CategoriesFailure(failure.errMessage)),
        (_) => fetchCategories(), // Refresh the list after updating
      );
    } catch (e) {
      emit(CategoriesFailure('Failed to update category: $e'));
    }
  }
}
