import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/functions/show_error_snack_bar.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/billings/presentation/managers/cubit/bill_cubit.dart';
import 'package:shops_manager_offline/features/products/data/models/product_model.dart';

class QuantityCell extends StatelessWidget {
  final ProductModel product;
  final int index;
  final BillCubit billsCubit;

  const QuantityCell({
    super.key,
    required this.product,
    required this.index,
    required this.billsCubit,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                if (product.billQuantity < product.wareHouseQuantity) {
                  billsCubit.updateBillQuantity(
                      index, product.billQuantity + 1);
                } else {
                  showErrorSnackBar(
                      context, "الكمية المطلوبة غير متاحة في المخزن");
                }
              },
              icon: const Icon(Icons.add),
            ),
            Text(
              product.wareHouseQuantity == 0
                  ? "عذرا هذا العنصر غير متوفر في المخزن "
                  : product.billQuantity.toString(),
              style: AppStyles.styleRegular16(context),
            ),
            IconButton(
              onPressed: () {
                if (product.billQuantity > 1) {
                  billsCubit.updateBillQuantity(
                      index, product.billQuantity - 1);
                }
              },
              icon: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
