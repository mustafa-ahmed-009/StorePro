import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/billings/presentation/managers/cubit/bill_cubit.dart';

class MonthBillsView extends StatelessWidget {
  const MonthBillsView({super.key, required this.month});
  final String month;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => BillCubit()..fetchMontlyBills(month: month),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'عرض الفواتير حسب الشهر',
              style: AppStyles.styleSemiBold20(context),
            ),
          ),
          body: BlocBuilder<BillCubit, BillState>(
            builder: (context, state) {
              if (state is BillSuccess) {
                final double total =
                    context.read<BillCubit>().calculateBillTotal();
                return Column(
                  children: [
                    Text(
                        "اجمالي فواتير الشهر الحالي ${total.toStringAsFixed(2)}",
                        style: AppStyles.styleSemiBold16(context)),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.listOfBills.length,
                        itemBuilder: (context, index) {
                          final bill = state.listOfBills[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            elevation: 2,
                            child: ListTile(
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
                                    "التاريخ: ${bill.createdAt}",
                                    style: AppStyles.styleRegular14(context)
                                        .copyWith(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "المبلغ: ${bill.total.toStringAsFixed(2)}",
                                    style: AppStyles.styleMedium16(context)
                                        .copyWith(
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
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
                        state.errorMessage,
                        style: AppStyles.styleRegular16(context).copyWith(
                          color: Colors.red[600],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
