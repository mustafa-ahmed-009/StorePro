import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';

Future<dynamic> showDeleteDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "تأكيد الحذف",
            style: AppStyles.styleSemiBold18(context), // Semi-bold 18 for the title
          ),
          content: Text(
            "هل أنت متأكد أنك تريد حذف هذا المنتج؟",
            style: AppStyles.styleRegular16(context), // Regular 16 for the content
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "إلغاء",
                style: AppStyles.styleMedium16(context), // Medium 16 for the cancel button
              ),
              onPressed: () {
                Navigator.of(context).pop(false); // Return false if canceled
              },
            ),
            TextButton(
              child: Text(
                "حذف",
                style: AppStyles.styleBold16(context), // Bold 16 for the delete button
              ),
              onPressed: () {
                Navigator.of(context).pop(true); // Return true if confirmed
              },
            ),
          ],
        );
      },
    );
}