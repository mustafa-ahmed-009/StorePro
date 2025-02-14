import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/constants.dart';
import 'package:shops_manager_offline/core/functions/date_format.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/billings/data/models/bill_product_model.dart';
import 'package:shops_manager_offline/features/billings/presentation/managers/cubit/bill_cubit.dart';
import 'package:shops_manager_offline/features/billings/presentation/view/desktop/bill_adding_widgets/adding_bill_table_cell_widget.dart';

class BillDetails extends StatelessWidget {
  const BillDetails(
      {super.key,
      required this.billId,
      required this.totalAfterDiscount,
      required this.billDate,
      this.customerName,
      this.phoneNumber});
  final int billId;
  final double totalAfterDiscount;
  final String billDate;
  final String? customerName;
  final String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    double totalBeforeDiscount = 0;

    return BlocProvider(
      create: (context) => BillCubit()..fetchBillProducts(billId: billId),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "تفاصيل الفاتورة",
              style: AppStyles.styleSemiBold20(context),
            ),
          ),
          body: BlocBuilder<BillCubit, BillState>(
            builder: (context, state) {
              if (state is BillProductsByIdSuccess) {
                final List<BillProductModel> products = state.listOfBills;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            klogoPath,
                          ),
                        ),
                        Text(
                          "الرقم التعريفي الخاص بالفاتورة : $billId ",
                          style: AppStyles.styleMedium20(context),
                        ),
                        Table(
                          border: TableBorder(
                            horizontalInside: BorderSide(
                              color:
                                  Colors.grey.shade300, // Lighter border color
                              width: 1.0,
                            ),
                            verticalInside: BorderSide(
                              color:
                                  Colors.grey.shade300, // Lighter border color
                              width: 1.0,
                            ),
                            top: BorderSide(
                                color: Colors.grey.shade300, width: 1.0),
                            bottom: BorderSide(
                                color: Colors.grey.shade300, width: 1.0),
                            left: BorderSide(
                                color: Colors.grey.shade300, width: 1.0),
                            right: BorderSide(
                                color: Colors.grey.shade300, width: 1.0),
                          ),
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                              decoration: BoxDecoration(
                                color: Colors.blue
                                    .shade50, // Light blue background for header
                              ),
                              children: [
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      "الاسم",
                                      style: AppStyles.styleSemiBold16(
                                          context), // Use AppStyles
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      "السعر",
                                      style: AppStyles.styleSemiBold16(
                                          context), // Use AppStyles
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      "العدد",
                                      style: AppStyles.styleSemiBold16(
                                          context), // Use AppStyles
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      "الاجمالي",
                                      style: AppStyles.styleSemiBold16(
                                          context), // Use AppStyles
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ...products.map((product) {
                              totalBeforeDiscount += product.total;
                              return TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.white, // Alternate row colors
                                ),
                                children: [
                                  TableCellWidget(
                                    text: product.name!,
                                    style: AppStyles.styleRegular16(
                                        context), // Use AppStyles
                                  ),
                                  TableCellWidget(
                                    text: (product.total / product.quantity)
                                        .toString(),
                                    style: AppStyles.styleRegular16(
                                        context), // Use AppStyles
                                  ),
                                  TableCellWidget(
                                    text: product.quantity.toString(),
                                    style: AppStyles.styleRegular16(
                                        context), // Use AppStyles
                                  ),
                                  TableCellWidget(
                                    text: "${product.total}",
                                    style: AppStyles.styleRegular16(
                                        context), // Use AppStyles
                                  ),
                                ],
                              );
                            })
                          ],
                        ),
                        Text(
                          "تاريخ الفاتورة  ${formatDateInArabic(billDate)}",
                          style: AppStyles.styleSemiBold20(context),
                        ),
                        // Add a text field here to receive a discount percentage from the user
                        Text(
                          "اسم العميل : ${customerName ?? "غير مسجل"}",
                          style: AppStyles.styleMedium20(context),
                        ),
                        Text(
                          "رقم  العميل  : ${phoneNumber ?? "غير مسجل"}",
                          style: AppStyles.styleMedium20(context),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue
                                .shade50, // Light blue background for total
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                //   "الاجمالي: $overallTotal",
                                "نسبة الخصم ${(totalBeforeDiscount - totalAfterDiscount) / totalBeforeDiscount * 100} %",
                                style: AppStyles.styleSemiBold18(
                                    context), // Use AppStyles
                              ),
                              const SizedBox(height: 8),
                              // Display the discounted total if a discount is applied
                              Text(
                                "الاجمالي بعد الخصم : $totalAfterDiscount",
                                style: AppStyles.styleSemiBold20(context),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // const AdditionalProductAddingButton(),
                      ],
                    ),
                  ),
                );
              } else if (state is BillFailure) {
                return Center(
                  child: Text(
                    state.errorMessage,
                    style: AppStyles.styleRegular16(context), // Use AppStyles
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
