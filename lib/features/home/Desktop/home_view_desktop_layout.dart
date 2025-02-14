import 'package:flutter/material.dart';
import 'package:shops_manager_offline/features/billings/presentation/view/desktop/bill_view_by_date_widget/billing_view.dart';
import 'package:shops_manager_offline/features/home/Desktop/home_view_body.dart';
import 'package:shops_manager_offline/features/home/Desktop/home_view_side_bar.dart';
import 'package:shops_manager_offline/features/categories/presentation/views/desktop/catgories_dekstop_view.dart';
import 'package:shops_manager_offline/features/products/presentation/views/desktop/products_desktop_view.dart';
import 'package:shops_manager_offline/features/profile/presentation/widgets/profiel_view.dart';
import 'package:shops_manager_offline/features/statistics/presentation/widgets/statistics_view.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/views/Desktop/widgets/warehouses_widgets/warehouses_desktop_view.dart';

class HomeViewDesktopLayout extends StatefulWidget {
  const HomeViewDesktopLayout({super.key});

  @override
  State<HomeViewDesktopLayout> createState() => _HomeViewDesktopLayoutState();
}

class _HomeViewDesktopLayoutState extends State<HomeViewDesktopLayout> {
  List<Widget> routingWidgets = [
    HomeScreenViewBody(),
    const WareHouseDekstopView(),
    const CategoriesDesktopView(),
    const ProductsDesktopView(),
    const StatisticsView(), // Add more widgets here as needed
    const FinancialView(), // Add more widgets here as needed
    const ProfileView(), // Add more widgets here as needed
    // Add more widgets here as needed
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Row(
          children: [
            // Sidebar
            Sidebar(
              currentIndex: currentIndex,
              onItemSelected: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            // Content Area
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.white, // White background for content
                padding: const EdgeInsets.all(16), // Add padding
                child: routingWidgets[currentIndex],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
