import 'package:flutter/material.dart';
import 'package:shops_manager_offline/features/billings/presentation/managers/cubit/bill_cubit.dart';
import 'package:shops_manager_offline/features/billings/presentation/view/desktop/bill_adding_widgets/adding_bill_table_cell_widget.dart';
import 'package:shops_manager_offline/features/billings/presentation/view/desktop/bill_adding_widgets/adding_bill_table_quantity_cell.dart';
import 'package:shops_manager_offline/features/products/data/models/product_model.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart'; // Import AppStyles

class ProductDetailsSection extends StatelessWidget {
  final List<ProductModel> products;
  final BillCubit billsCubit;
  final double overallTotal;

  const ProductDetailsSection({
    super.key,
    required this.products,
    required this.billsCubit,
    required this.overallTotal,
  });

  @override
  Widget build(BuildContext context) {
    // Controller for the discount percentage input
    final TextEditingController discountController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Table(
          border: TableBorder(
            horizontalInside: BorderSide(
              color: Colors.grey.shade300, // Lighter border color
              width: 1.0,
            ),
            verticalInside: BorderSide(
              color: Colors.grey.shade300, // Lighter border color
              width: 1.0,
            ),
            top: BorderSide(color: Colors.grey.shade300, width: 1.0),
            bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
            left: BorderSide(color: Colors.grey.shade300, width: 1.0),
            right: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.blue.shade50, // Light blue background for header
              ),
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "الاسم",
                      style:
                          AppStyles.styleSemiBold16(context), // Use AppStyles
                    ),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "السعر",
                      style:
                          AppStyles.styleSemiBold16(context), // Use AppStyles
                    ),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "العدد",
                      style:
                          AppStyles.styleSemiBold16(context), // Use AppStyles
                    ),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "الاجمالي",
                      style:
                          AppStyles.styleSemiBold16(context), // Use AppStyles
                    ),
                  ),
                ),
              ],
            ),
            ...products.map((product) {
              final index = products.indexOf(product);
              if (product.wareHouseQuantity == 0) {
                // billsCubit.setBillAddingStatusToFalse();
              }
              return TableRow(
                decoration: BoxDecoration(
                  color: index.isEven
                      ? Colors.grey.shade50
                      : Colors.white, // Alternate row colors
                ),
                children: [
                  TableCellWidget(
                    text: product.name,
                    style: AppStyles.styleRegular16(context), // Use AppStyles
                  ),
                  TableCellWidget(
                    text: product.customerPrice.toString(),
                    style: AppStyles.styleRegular16(context), // Use AppStyles
                  ),
                  QuantityCell(
                    product: product,
                    index: index,
                    billsCubit: billsCubit,
                  ),
                  TableCellWidget(
                    text: "${product.customerPrice * product.billQuantity}",
                    style: AppStyles.styleRegular16(context), // Use AppStyles
                  ),
                ],
              );
            })
          ],
        ),
        // Add a text field here to receive a discount percentage from the user
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: discountController,
            decoration: InputDecoration(
              labelText: "نسبة الخصم (%)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              // Update the discount percentage in the cubit or state
              final discountPercentage = double.tryParse(value) ?? 0.0;
              //   billsCubit.updateDiscountPercentage(discountPercentage);
            },
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50, // Light blue background for total
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "الاجمالي: $overallTotal",
                style: AppStyles.styleSemiBold18(context), // Use AppStyles
              ),
              const SizedBox(height: 8),
              // Display the discounted total if a discount is applied
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: discountController,
                builder: (context, value, _) {
                  final discountPercentage = double.tryParse(value.text) ?? 0.0;
                  final discountedTotal =
                      overallTotal * (1 - discountPercentage / 100);
                  billsCubit.overAllTotal = discountedTotal;
                  return Text(
                    "الاجمالي بعد الخصم: ${discountedTotal.toStringAsFixed(2)}",
                    style: AppStyles.styleSemiBold18(context),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // const AdditionalProductAddingButton(),
      ],
    );
  }
}
