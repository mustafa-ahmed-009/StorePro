import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/billings/data/models/bill_model.dart';
import 'package:shops_manager_offline/features/billings/presentation/managers/cubit/bill_cubit.dart';
import 'package:shops_manager_offline/features/billings/presentation/view/desktop/bill_view_by_date_widget/list_view_card_item.dart';

class BillsListViewBlocBuilder extends StatelessWidget {
  const BillsListViewBlocBuilder({super.key, required this.currentDate});
  final String currentDate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillCubit, BillState>(
      builder: (context, state) {
        if (state is BillSuccess) {
          List<BillModel> listOfBills = state.listOfBills;
          final double billTotal =
              context.read<BillCubit>().calculateBillTotal();
          if (listOfBills.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "لا توجد فواتير لهذا اليوم",
                    style: AppStyles.styleRegular16(context).copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Text(
                  "اجمالي فواتير اليوم ${billTotal}",
                  style: AppStyles.styleSemiBold20(context),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.listOfBills.length,
                    itemBuilder: (context, index) {
                      final bill = state.listOfBills[index];
                      return ListViewCardItem(bill: bill);
                    },
                  ),
                ),
              ],
            );
          }
        } else if (state is BillFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red[400],
                ),
                const SizedBox(height: 16),
                Text(
                  "حدث خطأ أثناء جلب البيانات",
                  style: AppStyles.styleRegular16(context).copyWith(
                    color: Colors.red[600],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
