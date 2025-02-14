import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/managers/cubit/warehouses_cubit.dart';

class DeleteWarehouseDialog extends StatelessWidget {
  final int id;
  final WarehouseCubit warehouseCubit;

  const DeleteWarehouseDialog({
    super.key,
    required this.id,
    required this.warehouseCubit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'حذف المخزن',
        style: AppStyles.styleSemiBold18(context),
      ),
      content: Text(
        'هل أنت متأكد أنك تريد حذف هذا المخزن؟',
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
            warehouseCubit.deleteWarehouse(id);
            Navigator.pop(context);
          },
          child: Text(
            'حذف',
            style: AppStyles.styleSemiBold16(context),
          ),
        ),
      ],
    );
  }
}