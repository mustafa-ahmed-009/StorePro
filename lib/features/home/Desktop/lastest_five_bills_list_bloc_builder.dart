import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart'; // Import the AppStyles
import 'package:shops_manager_offline/features/billings/data/models/bill_model.dart';
import 'package:shops_manager_offline/features/billings/presentation/managers/cubit/bill_cubit.dart';
import 'package:shops_manager_offline/features/billings/presentation/view/desktop/billing_detials/bill_details.dart';

class LastestFiveBillsListBlocBuilder extends StatelessWidget {
  const LastestFiveBillsListBlocBuilder({super.key, required this.billCubit});
  final BillCubit billCubit;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillCubit, BillState>(
      bloc: billCubit,
      builder: (context, state) {
        if (state is BillLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BillFailure) {
          return Center(child: Text(state.errorMessage));
        } else if (state is BillSuccess) {
          final List<BillModel> bills = state.listOfBills;
          if (bills.isEmpty) {
            return Center(
              child: Text(
                'لا توجد فواتير متاحة.',
                style: AppStyles.styleRegular16(context), // Use AppStyles
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'هذه هي أحدث خمس فواتير', // Arabic text
                  style: AppStyles.styleSemiBold20(context), // Use AppStyles
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bills.length,
                  itemBuilder: (context, index) {
                    final bill = bills[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(
                          'رقم الفاتورة: ${bill.id}',
                          style:
                              AppStyles.styleMedium16(context), // Use AppStyles
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'العميل: ${bill.customerName ?? "غير مسجل"}',
                              style: AppStyles.styleRegular14(
                                  context), // Use AppStyles
                            ),
                            Text(
                              'الهاتف: ${bill.phoneNumber ?? "غير مسجل"}',
                              style: AppStyles.styleRegular14(
                                  context), // Use AppStyles
                            ),
                            Text(
                              'الإجمالي: ${bill.total.toStringAsFixed(2)}',
                              style: AppStyles.styleRegular14(
                                  context), // Use AppStyles
                            ),
                            Text(
                              'التاريخ: ${bill.createdAt}',
                              style: AppStyles.styleRegular14(
                                  context), // Use AppStyles
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BillDetails(
                                          phoneNumber: bill.phoneNumber,
                                          customerName: bill.customerName,
                                          billDate: bill.createdAt,
                                          totalAfterDiscount: bill.total,
                                          billId: bill.id!,
                                        )));
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Text(
              'لا توجد بيانات متاحة.',
              style: AppStyles.styleRegular16(context), // Use AppStyles
            ),
          );
        }
      },
    );
  }
}
