import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/functions/date_format.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/billings/data/models/bill_model.dart';
import 'package:shops_manager_offline/features/billings/presentation/managers/cubit/bill_cubit.dart';

void showBillDetailsDialog(BuildContext context, BillModel bill) {
  // Create a new instance of BillCubit for the dialog
  final dialogCubit = BillCubit();

  showDialog(
    context: context,
    builder: (context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text(
            "تفصيل الفاتورة",
            style: AppStyles.styleSemiBold20(context),
          ),
          content: SingleChildScrollView(
            child: BlocProvider.value(
              value: dialogCubit..fetchBillProducts(billId: bill.id!),
              child: BlocBuilder<BillCubit, BillState>(
                builder: (context, state) {
                  if (state is BillLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is BillProductsByIdSuccess) {
                    final billProducts = state.listOfBills;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Bill Details
                        Text(
                          "العميل: ${bill.customerName ?? "غير مسجل"}",
                          style: AppStyles.styleMedium16(context),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "التاريخ: ${formatDateInArabic(bill.createdAt)}",
                          style: AppStyles.styleRegular14(context),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "المبلغ الإجمالي: ${bill.total.toStringAsFixed(2)}",
                          style: AppStyles.styleMedium16(context).copyWith(
                            color: Colors.green[700],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Products List
                        Text(
                          "المنتجات:",
                          style: AppStyles.styleSemiBold16(context),
                        ),
                        const SizedBox(height: 8),
                        ...billProducts.map((product) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              product.name ?? "اسم العميل غير مسجل",
                              style: AppStyles.styleMedium16(context),
                            ),
                            subtitle: Text(
                              "الكمية: ${product.quantity} - السعر: ${product.total.toStringAsFixed(2)}",
                              style: AppStyles.styleRegular14(context),
                            ),
                            trailing: Text(
                              "المجموع: ${(product.total * product.quantity).toStringAsFixed(2)}",
                              style: AppStyles.styleMedium16(context).copyWith(
                                color: Colors.blue[700],
                              ),
                            ),
                          );
                        }),
                      ],
                    );
                  } else if (state is BillFailure) {
                    return Center(
                      child: Text(
                        "حدث خطأ أثناء جلب البيانات",
                        style: AppStyles.styleRegular16(context).copyWith(
                          color: Colors.red[600],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "لا توجد بيانات",
                        style: AppStyles.styleRegular16(context),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                dialogCubit.close(); // Dispose of the dialog's Cubit
              },
              child: Text(
                "إغلاق",
                style: AppStyles.styleMedium16(context).copyWith(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
