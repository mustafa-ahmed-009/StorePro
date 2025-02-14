import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/constants.dart';
import 'package:shops_manager_offline/core/functions/show_error_snack_bar.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/billings/presentation/managers/cubit/bill_cubit.dart';
import 'package:shops_manager_offline/features/billings/presentation/view/desktop/bill_adding_widgets/adding_bill_customer_details_sections.dart';
import 'package:shops_manager_offline/features/billings/presentation/view/desktop/bill_adding_widgets/adding_bill_products_details_section.dart';
import 'package:shops_manager_offline/features/billings/presentation/view/desktop/bill_adding_widgets/adding_bill_submit_button.dart';
import 'package:shops_manager_offline/features/billings/presentation/view/desktop/bill_adding_widgets/additional_product_adding_button.dart';

class BillingsAddingDetail extends StatelessWidget {
  const BillingsAddingDetail({super.key, required this.receviedBarCode});
  final String receviedBarCode;

  @override
  Widget build(BuildContext context) {
    final TextEditingController customerNameController =
        TextEditingController();
    final TextEditingController customerPhoneController =
        TextEditingController();

    return BlocProvider(
      create: (context) =>
          BillCubit()..fetchProductByBarcode(barCode: receviedBarCode),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "تفاصيل الفاتورة",
              style: AppStyles.styleSemiBold24(context),
            ),
            centerTitle: true,
          ),
          body: BlocConsumer<BillCubit, BillState>(
            listener: (context, state) {
              // You can add logic here to handle state changes, such as showing a snackbar or navigating to another screen
              if (state is BillFailure) {
                showErrorSnackBar(context, state.errorMessage);
              }
              if (state is BillAddingSuccess) {
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              if (state is BillProductFetchingSuccess) {
                final BillCubit billCubit = context.read<BillCubit>();

                final double overallTotal =
                    billCubit.calculateBillAddingTotal();
                billCubit.checkIfIcanAddTheBill();
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      spacing: 12,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            klogoPath,
                          ),
                        ),
                        ProductDetailsSection(
                          products: billCubit.billProductsList,
                          billsCubit: billCubit,
                          overallTotal: overallTotal,
                        ),
                        AdditionalProductAddingButton(),
                        CustomerDetailsSection(
                          customerNameController: customerNameController,
                          customerPhoneController: customerPhoneController,
                        ),
                        SubmitButton(
                          billsCubit: billCubit,
                          customerNameController: customerNameController,
                          customerPhoneController: customerPhoneController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
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
