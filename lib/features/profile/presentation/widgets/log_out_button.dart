import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/auth/presentation/widgets/login/login_view.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 12), // Adjust padding
        backgroundColor: Colors.red, // Use a red color for logout actions
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        elevation: 2, // Add a slight shadow
      ),
      child: Row(
        mainAxisSize:
            MainAxisSize.min, // Ensure the row takes only the required space
        children: [
          const Icon(Icons.logout, color: Colors.white), // Add a logout icon
          const SizedBox(width: 8), // Add spacing between icon and text
          Text(
            "تسجيل الخروج",
            style: AppStyles.styleMedium16(context)
                .copyWith(color: Colors.white), // Use your AppStyles
          ),
        ],
      ),
    );
  }
}
