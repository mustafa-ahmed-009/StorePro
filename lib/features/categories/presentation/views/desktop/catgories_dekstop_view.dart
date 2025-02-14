import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/functions/check_if_is_admin.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/categories/presentation/managers/cubit/categories_cubit.dart';
import 'package:shops_manager_offline/features/categories/presentation/views/desktop/add_category_dialog.dart';
import 'package:shops_manager_offline/features/categories/presentation/views/desktop/categories_grid_view_builder.dart';
import 'package:shops_manager_offline/features/categories/presentation/views/desktop/filtering_ui.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/managers/cubit/warehouses_cubit.dart';

class CategoriesDesktopView extends StatelessWidget {
  const CategoriesDesktopView({super.key});

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
                            onPressed: () =>
                                checkAdminAndShowDialog<CategoriesCubit>(
                                  context: context,
                                  cubit:
                                      CategoriesCubit(), // Use the existing cubit instance
                                  showDialogCallback: (context, cubit) {
                                    showAddCategoryDialog(
                                      context: context,
                                      warehouses: warehouseState.warehouses,
                                      categoriesCubit:
                                          categoriesCubit, // Pass the cubit from the callback
                                    );
                                  },
                                )),
                        // Categories Grid View
                        Expanded(
                          child: BlocBuilder<CategoriesCubit, CategoriesState>(
                            builder: (context, state) {
                              if (state is CategoriesSuccess) {
                                return state.categories.isEmpty
                                    ? Text(
                                        " لايوجد اصناف اللي الان برجاء اضافة صنف اذا كنت تمتك الصلاحيات المناسبة ",
                                        style: AppStyles.styleMedium20(context),
                                      )
                                    : CategoriesGridViewBuilder(
                                        categoriesCubit: categoriesCubit,
                                        crossAxisCount: 4,
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
