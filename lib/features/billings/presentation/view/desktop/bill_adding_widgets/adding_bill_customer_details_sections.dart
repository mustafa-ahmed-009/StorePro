import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';

class CustomerDetailsSection extends StatelessWidget {
  final TextEditingController customerNameController;
  final TextEditingController customerPhoneController;

  const CustomerDetailsSection({
    super.key,
    required this.customerNameController,
    required this.customerPhoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "تفاصيل العميل",
          style: AppStyles.styleSemiBold20(context),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: customerNameController,
          textAlign: TextAlign.right,
          style: AppStyles.styleRegular16(context),
          decoration: InputDecoration(
            labelText: "اسم العميل",
            labelStyle: AppStyles.styleRegular14(context),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: customerPhoneController,
          textAlign: TextAlign.right,
          keyboardType: TextInputType.phone,
          style: AppStyles.styleRegular16(context),
          decoration: InputDecoration(
            labelText: "رقم الهاتف",
            labelStyle: AppStyles.styleRegular14(context),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
