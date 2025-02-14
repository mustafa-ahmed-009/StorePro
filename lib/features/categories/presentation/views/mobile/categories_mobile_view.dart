import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/features/categories/presentation/managers/cubit/categories_cubit.dart';
import 'package:shops_manager_offline/features/categories/presentation/views/desktop/add_category_dialog.dart';
import 'package:shops_manager_offline/features/categories/presentation/views/desktop/categories_grid_view_builder.dart';
import 'package:shops_manager_offline/features/categories/presentation/views/desktop/filtering_ui.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/managers/cubit/warehouses_cubit.dart';

class CategoriesMobileView extends StatelessWidget {
  const CategoriesMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CategoriesCubit()..fetchCategories()),
        BlocProvider(create: (context) => WarehouseCubit()..fetchWarehouses()),
      ],
      child: Builder(
        builder: (context) {
          final CategoriesCubit categoriesCubit =
              context.read<CategoriesCubit>();
          return BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, categoriesState) {
              return BlocBuilder<WarehouseCubit, WarehouseState>(
                builder: (context, warehouseState) {
                  if (categoriesState is CategoriesLoading ||
                      warehouseState is WarehouseLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (categoriesState is CategoriesSuccess &&
                      warehouseState is WarehouseSuccess) {
                    return Column(
                      children: [
                        // Filtering UI
                        filterByWarehouses(
                          context: context,
                          warehouses: warehouseState.warehouses,
                          onFilter: (warehouseId) {
                            categoriesCubit
                                .filterCategoriesByWarehouse(warehouseId);
                          },
                        ),
                        // Add Category Button
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => showAddCategoryDialog(
                            context: context,
                            categoriesCubit: categoriesCubit,
                            warehouses: warehouseState.warehouses,
                          ),
                        ),
                        // Categories Grid View
                        Expanded(
                          child: BlocBuilder<CategoriesCubit, CategoriesState>(
                            builder: (context, state) {
                              if (state is CategoriesSuccess) {
                                return CategoriesGridViewBuilder(
                                  categoriesCubit: categoriesCubit,
                                  crossAxisCount: 2,
                                  categories: state.categories,
                                );
                              } else {
                                return const Center(
                                    child: Text('No data available'));
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (categoriesState is CategoriesFailure) {
                    return Center(
                      child: Text(
                        categoriesState.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (warehouseState is WarehouseFailure) {
                    return Center(
                      child: Text(
                        warehouseState.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
