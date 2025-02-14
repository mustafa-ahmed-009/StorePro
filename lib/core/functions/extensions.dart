import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';

extension SnackBarExtension on BuildContext {
  void showErrorSnackBar({required String message}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppStyles.styleSemiBold18(this),
        ),
        backgroundColor: Colors.red,
        duration: Duration(milliseconds: 1000),
      ),
    );
  }

  void showSuccessSnackBar({required String message}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: AppStyles.styleSemiBold18(this)),
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 1000),
      ),
    );
  }
  
}
