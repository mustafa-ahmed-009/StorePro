// Sidebar Widget
import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/home/Desktop/side_bar_item.dart';

class Sidebar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemSelected;

  const Sidebar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.grey[200], // Light grey background
        child: Column(
          children: [
            // Sidebar Header
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue, // Header background color
              child: Center(
                child: Text(
                  "إدارة المتاجر",
                  style: AppStyles.styleSemiBold20(context).copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Navigation Items
            SidebarItem(
              icon: Icons.home,
              title: "الرئيسية",
              index: 0,
              currentIndex: currentIndex,
              onItemSelected: onItemSelected,
            ),
            SidebarItem(
              icon: Icons.warehouse,
              title: "المخازن",
              index: 1,
              currentIndex: currentIndex,
              onItemSelected: onItemSelected,
            ),
            SidebarItem(
              icon: Icons.category,
              title: "الاصناف",
              index: 2,
              currentIndex: currentIndex,
              onItemSelected: onItemSelected,
            ),
            SidebarItem(
              icon: Icons.inventory,
              title: "المنتجات",
              index: 3,
              currentIndex: currentIndex,
              onItemSelected: onItemSelected,
            ),
            SidebarItem(
              icon: Icons.bar_chart,
              title: " احصائيات ",
              index: 4,
              currentIndex: currentIndex,
              onItemSelected: onItemSelected,
            ),
            SidebarItem(
              icon: Icons.attach_money,
              title: "المالية",
              index: 5,
              currentIndex: currentIndex,
              onItemSelected: onItemSelected,
            ),
            SidebarItem(
              icon: Icons.person,
              title: "حسابي",
              index: 6,
              currentIndex: currentIndex,
              onItemSelected: onItemSelected,
            ),
          ],
        ),
      ),
    );
  }
}
