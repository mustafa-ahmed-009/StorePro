import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/warehouses/data/models/warehouses_model.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/managers/cubit/warehouses_cubit.dart';

class UpdateWarehouseDialog extends StatelessWidget {
  final WarehouseModel warehouse;
  final TextEditingController nameController;
  final WarehouseCubit warehouseCubit;

  const UpdateWarehouseDialog({
    super.key,
    required this.warehouse,
    required this.nameController,
    required this.warehouseCubit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'تحديث المخزن',
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
                    warehouseCubit.updateWarehouse(wareHouseId: warehouse.id! ,additionalQuantity: 0);
              Navigator.pop(context);
            }
          },
          child: Text(
            'تحديث',
            style: AppStyles.styleSemiBold16(context),
          ),
        ),
      ],
    );
  }
}
