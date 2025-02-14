import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/functions/shared_preferences.dart';
import 'package:shops_manager_offline/core/widgets/adaptive_layout.dart';
import 'package:shops_manager_offline/features/auth/presentation/widgets/login/login_view.dart';
import 'package:shops_manager_offline/features/home/Desktop/home_view_desktop_layout.dart';
import 'package:shops_manager_offline/features/home/mobile/home_mobile_view.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data == true) {
            return AdaptiveLayout(
              mobileLayout: (context) => const HomeMobileView(),
              tableLayout: (context) => const HomeViewDesktopLayout(),
              desktopLayout: (context) => const HomeViewDesktopLayout(),
            );
          } else {
            return const LoginScreen();
          }
        });
  }
}

// Warehouse View Widget

// Financial View Widget
