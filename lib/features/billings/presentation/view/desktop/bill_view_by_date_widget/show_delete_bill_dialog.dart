import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/billings/data/models/bill_model.dart';
import 'package:shops_manager_offline/features/billings/presentation/managers/cubit/bill_cubit.dart';

void showBillDelteDialog(
    BuildContext context, BillCubit billCubit, BillModel bill) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "تأكيد الحذف",
          style: AppStyles.styleSemiBold16(context),
        ),
        content: Text(
          "هل أنت متأكد أنك تريد حذف الفاتورة؟",
          style: AppStyles.styleRegular14(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(
              "إلغاء",
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              billCubit.detelBillAndBillProducts(
                  billId: bill.id!, billDate: bill.createdAt);
              Navigator.of(context).pop(); // Close the dialog
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[700],
            ),
            child: const Text("حذف"),
          ),
        ],
      );
    },
  );
}
