import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/features/categories/presentation/managers/cubit/categories_cubit.dart';
import 'package:shops_manager_offline/features/warehouses/data/models/warehouses_model.dart';

Widget filterByWarehouses({
  required BuildContext context,
  required List<WarehouseModel> warehouses,
  required Function(int?) onFilter,
}) {
  final CategoriesCubit categoriesCubit = context.read<CategoriesCubit>();
  final int? selectedWarehouseId = categoriesCubit.selectedWarehouseId;

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: DropdownButton<int>(
      hint: const Text('Filter by Warehouse'),
      value: selectedWarehouseId,
      items: [
        const DropdownMenuItem<int>(
          value: null,
          child: Text('كل المخازن'),
        ),
        ...warehouses.map((warehouse) {
          return DropdownMenuItem<int>(
            value: warehouse.id,
            child: Text(warehouse.name),
          );
        }),
      ],
      onChanged: (value) {
        categoriesCubit
            .setSelectedWarehouseId(value); // Update the selected warehouse ID
        onFilter(value); // Call the filtering function
      },
    ),
  );
}
