import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/billings/presentation/managers/cubit/billings_cubit.dart';

class DailyTotalTextAndButton extends StatelessWidget {
  const DailyTotalTextAndButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BillingCubit(),
      child: BlocBuilder<BillingCubit, BillingsState>(
        builder: (context, state) {
          return Column(
            children: [
              TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => BillDetails(
                    //               billCubit: 222,
                    //             )));
                  },
                  child: Text("عرض تفاصيل مالية اليوم")),
              Text("اجمالي مالية اليوم ",
                  style: AppStyles.styleSemiBold16(context)),
            ],
          );
        },
      ),
    );
  }
}
