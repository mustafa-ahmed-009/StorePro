
import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/billings/data/data_source/bill_data_source.dart';
import 'package:shops_manager_offline/features/billings/presentation/view/desktop/billing_detials/bill_details.dart';

class BillSearchBarWidget extends StatelessWidget {
  const BillSearchBarWidget({super.key, required this.hintText});
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      barHintText: hintText,
      barLeading: const Icon(Icons.search),
      suggestionsBuilder: (context, controller) async {
        final text = controller.text;

        // If no search word is entered, display a message
        if (text.isEmpty) {
          return [
            Card(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: const Icon(Icons.info, color: Colors.blue),
                title: Text(
                  "الرجاء إدخال كلمة بحث",
                  style: AppStyles.styleSemiBold16(context), // Use AppStyles
                ),
              ),
            ),
          ];
        }

        // Fetch products from the data source
        final response = await BillDataSource().searchForABill(text);

        // If no products are found, display a message
        if (response.isEmpty) {
          return [
            Card(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: const Icon(Icons.warning, color: Colors.orange),
                title: Text(
                  "لم يتم العثور على نتائج",
                  style: AppStyles.styleSemiBold16(context), // Use AppStyles
                ),
                subtitle: Text(
                  "تأكد من صحة كلمة البحث أو حاول باستخدام كلمات أخرى",
                  style: AppStyles.styleRegular14(context), // Use AppStyles
                ),
              ),
            ),
          ];
        }

        // Generate ListTile widgets for each product
        return List<Widget>.generate(response.length, (index) {
          final bill = response[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              leading: const Icon(Icons.shopping_bag, color: Colors.blue),
              title: Text(
                bill.createdAt,
                style: AppStyles.styleSemiBold16(context), // Use AppStyles
              ),
              subtitle: Text(
                "السعر: ${bill.total} جنيه",
                style: AppStyles.styleRegular14(context), // Use AppStyles
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BillDetails(
                      billId: bill.id!,
                      billDate: bill.createdAt,
                      customerName: bill.customerName,
                      phoneNumber: bill.phoneNumber,
                      totalAfterDiscount: bill.total,
                    ),
                  ),
                );
              },
            ),
          );
        });
      },
    );
  }
}
