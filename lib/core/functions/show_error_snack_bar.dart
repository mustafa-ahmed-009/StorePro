import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';

void showErrorSnackBar(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: 750),
      content: Text(
        errorMessage,
        style: AppStyles.styleRegular14(context), // Use your custom style
      ),
      backgroundColor: Colors.red, // Optional: Customize background color
      behavior: SnackBarBehavior.floating, // Optional: Floating style
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
      ),
    ),
  );
}
