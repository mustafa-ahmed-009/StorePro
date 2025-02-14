import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/functions/extensions.dart';
import 'package:shops_manager_offline/core/functions/shared_preferences.dart';

Future<void> checkAdminAndShowDialog<T>({
  required BuildContext context,
  required T cubit,
  required void Function(BuildContext context, T cubit) showDialogCallback,
}) async {
  final isAdminUser = await isAdmin(); // Check if the user is an admin

  if (!context.mounted) return; // Ensure the widget is still in the tree

  if (isAdminUser) {
    showDialogCallback(context, cubit); // Call the provided callback
  } else {
    context.showErrorSnackBar(
      message: 'عذرا لا يمكنك القيام بهذه العملية',
    );
  }
}
