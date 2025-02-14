import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/functions/check_if_is_admin.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/categories/presentation/managers/cubit/categories_cubit.dart';
import 'package:shops_manager_offline/features/products/presentation/manager/cubit/products_cubit.dart';
import 'package:shops_manager_offline/features/products/presentation/views/desktop/product_list_builder.dart';
import 'package:shops_manager_offline/features/products/presentation/views/desktop/products_category_builder.dart';
import 'package:shops_manager_offline/features/products/presentation/views/desktop/show_add_product_dialog.dart';
import 'package:shops_manager_offline/features/products/presentation/views/desktop/warehouses_bloc_builder.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/managers/cubit/warehouses_cubit.dart';

class ProductsDesktopView extends StatelessWidget {
  const ProductsDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WarehouseCubit()..fetchWarehouses()),
        BlocProvider(create: (context) => CategoriesCubit()..fetchCategories()),
        BlocProvider(create: (context) => ProductsCubit()..fetchAllProducts()),
      ],
      child: Builder(
        builder: (context) => Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(context),
        ),
      ),
    );
  }

  /// Builds the AppBar with title and actions.
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'المنتجات', // Arabic for "Products"
        style: AppStyles.styleSemiBold20(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => checkAdminAndShowDialog<CategoriesCubit>(
            context: context,
            cubit: CategoriesCubit(), // Use the existing cubit instance
            showDialogCallback: (context, cubit) {
              openAddProductDialog(
                context,
              );
            },
          ),
        ),
      ],
    );
  }

  /// Builds the main body of the view.
  Widget _buildBody(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final productsCubit = context.read<ProductsCubit>();
        final filteredProducts = productsCubit.getFilteredProducts();
        log(filteredProducts.toString());
        return Column(
          children: [
            Row(
              spacing: 12,
              children: [
                buildWarehouseDropdown(context, productsCubit),
                if (productsCubit.selectedWarehouseId != null)
                  buildCategoryDropdown(context, productsCubit),
              ],
            ),
            filteredProducts.isEmpty
                ? Text(
                    "لا يوجد منتاجات الي الان برجاء اضافة منتج اذا كنت تمتلك الصلاحيات المناسبة ",
                    style: AppStyles.styleMedium20(context),
                  )
                : buildProductList(context, filteredProducts, productsCubit),
          ],
        );
      },
    );
  }
}

/// Opens the add product dialog.
void openAddProductDialog(BuildContext context) {
  showAddProductDialog(
    context: context,
    productsCubit: context.read<ProductsCubit>(),
    warehouseCubit: context.read<WarehouseCubit>(),
    categoriesCubit: context.read<CategoriesCubit>(),
  );
}
