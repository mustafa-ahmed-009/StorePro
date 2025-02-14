import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/profile/presentation/managers/cubit/profile_cubit.dart';
import 'package:shops_manager_offline/features/profile/presentation/widgets/add_user_page.dart';

class AddUserButton extends StatelessWidget {
  const AddUserButton({super.key, required this.profileCubit});
  final ProfileCubit profileCubit;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddUserPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'إضافة مستخدم',
        style: AppStyles.styleMedium16(context),
      ),
    );
  }
}
