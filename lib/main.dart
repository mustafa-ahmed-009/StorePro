import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/config/bloc_observer.dart';
import 'package:shops_manager_offline/core/config/data_base_config.dart';
import 'package:shops_manager_offline/core/constants.dart';
import 'package:shops_manager_offline/features/home/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  initializeDatabaseFactory();
  Bloc.observer = SimpleBlocObserver();

  runApp(const MyApp());
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        // This will color all ElevatedButtons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kMainColor, // Default background color
            foregroundColor: Colors.white, // Default text/icon color
          ),
        ),

        // This will color all TextButtons
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: kMainColor, // Default text color
          ),
        ),

        // This will color all OutlinedButtons
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: kMainColor, // Default text/icon color
            side: BorderSide(color: kMainColor), // Default border color
          ),
        ),

        // This sets the primary color for the app which affects many components
        primaryColor: kMainColor,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreenView(),
    );
  }
}
