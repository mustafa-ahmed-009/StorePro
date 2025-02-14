  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/categories/presentation/managers/cubit/categories_cubit.dart';
import 'package:shops_manager_offline/features/products/presentation/manager/cubit/products_cubit.dart';

Widget buildCategoryDropdown(BuildContext context, ProductsCubit productsCubit) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, categoriesState) {
        if (categoriesState is CategoriesLoading) {
          return const CircularProgressIndicator();
        } else if (categoriesState is CategoriesFailure) {
          return Text(
            'خطأ: ${categoriesState.errorMessage}',
            style: AppStyles.styleRegular16(context),
          );
        } else if (categoriesState is CategoriesSuccess) {
          final categories = categoriesState.categories
              .where((category) =>
                  category.warehouseId == productsCubit.selectedWarehouseId)
              .toList();
          return DropdownButton<int>(
            value: productsCubit.selectedCategoryId,
            hint: Text(
              'اختار الصنف',
              style: AppStyles.styleRegular16(context),
            ),
            items: categories.map((category) {
              return DropdownMenuItem<int>(
                value: category.id,
                child: Text(
                  category.name,
                  style: AppStyles.styleRegular16(context),
                ),
              );
            }).toList(),
            onChanged: (value) {
              productsCubit.setSelectedCategoryId(value);
            },
          );
        } else {
          return Text(
            'لم يتم العثور على أصناف',
            style: AppStyles.styleRegular16(context),
          );
        }
      },
    );
  }