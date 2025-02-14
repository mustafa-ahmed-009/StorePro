import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/auth/data/models/user_model.dart';
import 'package:shops_manager_offline/features/profile/presentation/widgets/change_password_dialog.dart';

class ChangingPasswordButton extends StatelessWidget {
  const ChangingPasswordButton({
    super.key, required this.user,
  });
  final UserModel user; 
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ChangePasswordDialog(
                  userId: user.id!,
                ));
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        backgroundColor: Colors.blue, // Customize button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'تغيير كلمة المرور',
        style: AppStyles.styleMedium16(context),
      ),
    );
  }
}
