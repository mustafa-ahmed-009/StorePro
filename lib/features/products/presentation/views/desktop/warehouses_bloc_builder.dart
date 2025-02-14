import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/products/presentation/manager/cubit/products_cubit.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/managers/cubit/warehouses_cubit.dart';

/// Builds the warehouse dropdown.
Widget buildWarehouseDropdown(
    BuildContext context, ProductsCubit productsCubit) {
  return BlocBuilder<WarehouseCubit, WarehouseState>(
    builder: (context, warehouseState) {
      if (warehouseState is WarehouseLoading) {
        return const CircularProgressIndicator();
      } else if (warehouseState is WarehouseFailure) {
        return Text(
          'خطأ: ${warehouseState.errorMessage}',
          style: AppStyles.styleRegular16(context),
        );
      } else if (warehouseState is WarehouseSuccess) {
        final warehouses = warehouseState.warehouses;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton<int>(
            value: productsCubit.selectedWarehouseId,
            hint: Text(
              'اختار المخزن',
              style: AppStyles.styleRegular16(context),
            ),
            items: warehouses.map((warehouse) {
              return DropdownMenuItem<int>(
                value: warehouse.id,
                child: Text(
                  warehouse.name,
                  style: AppStyles.styleRegular16(context),
                ),
              );
            }).toList(),
            onChanged: (value) {
              productsCubit.setSelectedWarehouseId(value);
            },
          ),
        );
      } else {
        return Text(
          'لم يتم العثور على مخازن',
          style: AppStyles.styleRegular16(context),
        );
      }
    },
  );
}
