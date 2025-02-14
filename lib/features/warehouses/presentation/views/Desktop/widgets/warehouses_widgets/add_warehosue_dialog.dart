import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/managers/cubit/warehouses_cubit.dart';

class AddWarehouseDialog extends StatelessWidget {
  final TextEditingController nameController;
  final WarehouseCubit warehouseCubit;

  const AddWarehouseDialog({
    super.key,
    required this.nameController,
    required this.warehouseCubit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'إضافة مخزن',
        style: AppStyles.styleSemiBold18(context),
      ),
      content: TextField(
        controller: nameController,
        decoration: InputDecoration(
          hintText: 'أدخل اسم المخزن',
          hintStyle: AppStyles.styleRegular14(context),
        ),
        style: AppStyles.styleRegular14(context),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'إلغاء',
            style: AppStyles.styleSemiBold16(context),
          ),
        ),
        TextButton(
          onPressed: () {
            final name = nameController.text.trim();
            if (name.isNotEmpty) {
              warehouseCubit.addWarehouse(name);
              Navigator.pop(context);
            }
          },
          child: Text(
            'إضافة',
            style: AppStyles.styleSemiBold16(context),
          ),
        ),
      ],
    );
  }
}