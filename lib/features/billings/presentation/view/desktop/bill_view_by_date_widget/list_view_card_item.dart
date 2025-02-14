import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/functions/date_format.dart';
import 'package:shops_manager_offline/core/functions/shared_preferences.dart';
import 'package:shops_manager_offline/core/functions/show_error_snack_bar.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/billings/data/models/bill_model.dart';
import 'package:shops_manager_offline/features/billings/presentation/managers/cubit/bill_cubit.dart';
import 'package:shops_manager_offline/features/billings/presentation/view/desktop/bill_view_by_date_widget/show_delete_bill_dialog.dart';
import 'package:shops_manager_offline/features/billings/presentation/view/desktop/billing_detials/bill_details.dart';

class ListViewCardItem extends StatelessWidget {
  const ListViewCardItem({
    super.key,
    required this.bill,
  });

  final BillModel bill;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      elevation: 2,
      child: ListTile(
        onTap: () {
          // Show the bill details in a dialog
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BillDetails(
                phoneNumber: bill.phoneNumber,
                customerName: bill.customerName,
                billDate: bill.createdAt,
                totalAfterDiscount: bill.total,
                billId: bill.id!,
              ),
            ),
          );
        },
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(
          Icons.receipt,
          size: 32,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          bill.customerName ?? "غير مسجل",
          style: AppStyles.styleSemiBold16(context),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              "التاريخ: ${formatDateInArabic(bill.createdAt)}",
              style: AppStyles.styleRegular14(context).copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "المبلغ: ${bill.total.toStringAsFixed(2)}",
              style: AppStyles.styleMedium16(context).copyWith(
                color: Colors.green[700],
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red[700],
              ),
              onPressed: () async {
                //         final bool isAdminUser = await isAdmin();
                // isAdminUser ?         showBillDelteDialog(context, context.read<BillCubit>(), bill): showErrorSnackBar(context, "عذرا ليس لديك صلاحيات حذف الفاتورة");
                showBillDelteDialog(context, context.read<BillCubit>(), bill);
              },
            ),
          ],
        ),
      ),
    );
  }
}
