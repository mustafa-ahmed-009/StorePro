import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/categories/presentation/managers/cubit/categories_cubit.dart';
import 'package:shops_manager_offline/features/products/presentation/manager/cubit/products_cubit.dart';
import 'package:shops_manager_offline/features/products/presentation/views/desktop/product_list_builder.dart';
import 'package:shops_manager_offline/features/products/presentation/views/desktop/products_category_builder.dart';
import 'package:shops_manager_offline/features/products/presentation/views/desktop/show_add_product_dialog.dart';
import 'package:shops_manager_offline/features/products/presentation/views/desktop/warehouses_bloc_builder.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/managers/cubit/warehouses_cubit.dart';

class ProductsMobileView extends StatelessWidget {
  const ProductsMobileView({super.key});

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
          appBar: AppBar(
            title: Text(
              'المنتجات', // Arabic for "Products"
              style: AppStyles.styleSemiBold20(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => openAddProductDialog(context),
              ),
            ],
          ),
          body: BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              final productsCubit = context.read<ProductsCubit>();
              final filteredProducts = productsCubit.getFilteredProducts();

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
                  buildProductList(context, filteredProducts, productsCubit),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

void openAddProductDialog(BuildContext context) {
  showAddProductDialog(
    context: context,
    productsCubit: context.read<ProductsCubit>(),
    warehouseCubit: context.read<WarehouseCubit>(),
    categoriesCubit: context.read<CategoriesCubit>(),
  );
}
