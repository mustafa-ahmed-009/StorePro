import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shops_manager_offline/features/billings/data/models/bill_model.dart';
import 'package:shops_manager_offline/features/billings/data/models/bill_product_model.dart';
import 'package:shops_manager_offline/features/billings/presentation/managers/cubit/bill_cubit.dart';
import 'package:shops_manager_offline/features/products/data/models/product_model.dart';
import 'package:shops_manager_offline/features/products/data/repo/product_repo.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/managers/cubit/warehouses_cubit.dart';

class SubmitButton extends StatelessWidget {
  final TextEditingController customerNameController;
  final TextEditingController customerPhoneController;
  final BillCubit billsCubit;

  const SubmitButton({
    super.key,
    required this.customerNameController,
    required this.customerPhoneController,
    required this.billsCubit,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final customerName = customerNameController.text;
        final customerPhone = customerPhoneController.text;

        if (billsCubit.canIAddTheBill != false) {
          DateTime now = DateTime.now(); // Current date and time
          await billsCubit.addBill(
              billModel: BillModel(
            createdAt: DateFormat('M-d-yyyy h:mm a').format(now),
            customerName: customerName, // p1
            phoneNumber: customerPhone, // p2
            total: billsCubit.overAllTotal!,
          ));
          for (var i = 0; i < billsCubit.billProductsList.length; i++) {
            ProductModel product = billsCubit.billProductsList[i];
            WarehouseCubit().updateWarehouse(
                wareHouseId: product.warehouseId,
                additionalQuantity: -product.billQuantity);

            await ProductsRepo().updateProduct(product.copyWith(
              billQuantity: 1,
              wareHouseQuantity:
                  product.wareHouseQuantity - product.billQuantity,
              soldQuantity: product.soldQuantity + product.billQuantity,
            ));
            await billsCubit.addProductModel(
                billProductModel: BillProductModel(
              productId: product.id!,
              billId: billsCubit.currentBillId!,
              name: product.name,
              total: product.customerPrice * product.billQuantity,
              createdAt: DateFormat('M-d-yyyy h:mm a').format(now),
              barcode: product.barcode,
              quantity: product.billQuantity,
            ));
          }
        } else {
          if (context.mounted) {
            Navigator.pop(context);
          }
        }
      },
      child: Column(
        children: [
          Text(billsCubit.canIAddTheBill
              ? "إضافة فاتورة"
              : "الرجوع الي الرئيسية"),
        ],
      ),
    );
  }
}
