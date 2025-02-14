import 'package:flutter/material.dart';
import 'package:shops_manager_offline/features/categories/presentation/managers/cubit/categories_cubit.dart';
import 'package:shops_manager_offline/features/warehouses/data/models/warehouses_model.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart'; // Import AppStyles

void showAddCategoryDialog({
  required BuildContext context,
  required CategoriesCubit categoriesCubit,
  required List<WarehouseModel> warehouses,
}) {
  final nameController = TextEditingController();
  int?
      selectedWarehouseId; // Track the selected warehouse ID for the new category

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(
              'إضافة فئة جديدة',
              style: AppStyles.styleSemiBold20(context), // Use AppStyles
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'اسم الفئة',
                    labelStyle:
                        AppStyles.styleRegular16(context), // Use AppStyles
                  ),
                  style: AppStyles.styleRegular16(context), // Use AppStyles
                ),
                const SizedBox(height: 16),
                DropdownButton<int>(
                  hint: Text(
                    'اختر المخزن',
                    style: AppStyles.styleRegular16(context), // Use AppStyles
                  ),
                  value: selectedWarehouseId,
                  items: warehouses.map((warehouse) {
                    return DropdownMenuItem<int>(
                      value: warehouse.id,
                      child: Text(
                        warehouse.name,
                        style:
                            AppStyles.styleRegular16(context), // Use AppStyles
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedWarehouseId = value; // Update the selected value
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text(
                  'إلغاء',
                  style: AppStyles.styleRegular16(context), // Use AppStyles
                ),
              ),
              TextButton(
                onPressed: () {
                  final name = nameController.text.trim();
                  if (name.isNotEmpty && selectedWarehouseId != null) {
                    // Ensure both name and warehouseId are valid
                    categoriesCubit.addCategory(name, selectedWarehouseId!);
                    Navigator.pop(context); // Close the dialog
                  } else {
                    // Show an error if name or warehouseId is missing
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'الرجاء إدخال اسم الفئة واختيار مستودع.',
                          style: AppStyles.styleRegular16(
                              context), // Use AppStyles
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  'إضافة',
                  style: AppStyles.styleSemiBold16(context), // Use AppStyles
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
