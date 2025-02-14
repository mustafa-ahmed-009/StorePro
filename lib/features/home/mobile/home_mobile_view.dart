import 'package:flutter/material.dart';
import 'package:shops_manager_offline/features/billings/presentation/view/desktop/bill_view_by_date_widget/billing_view.dart';
import 'package:shops_manager_offline/features/categories/presentation/views/mobile/categories_mobile_view.dart';
import 'package:shops_manager_offline/features/home/Desktop/home_view_body.dart';
import 'package:shops_manager_offline/features/products/presentation/views/mobile/mobile_products_view.dart';
import 'package:shops_manager_offline/features/profile/presentation/widgets/profiel_view.dart';
import 'package:shops_manager_offline/features/statistics/presentation/widgets/statistics_view.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/views/mobile/warehouse_mobile_view.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';

class HomeMobileView extends StatefulWidget {
  const HomeMobileView({super.key});

  @override
  State<HomeMobileView> createState() => _HomeMobileViewState();
}

class _HomeMobileViewState extends State<HomeMobileView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      HomeScreenViewBody(),
      WarehouseMobileView(),
      CategoriesMobileView(),
      ProductsMobileView(),
      StatisticsView(),
      FinancialView(),
      ProfileView(),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // Replace the DrawerHeader with this
              Container(
                padding: EdgeInsets.all(16), // Add padding as needed
                color: Colors.blue, // Keep the same background color
                child: SafeArea(
                  child: Text(
                    'القائمة',
                    style: AppStyles.styleSemiBold24(context).copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: selectedIndex == 0 ? Colors.blue : Colors.grey,
                ),
                title: Text(
                  'الرئيسية',
                  style: selectedIndex == 0
                      ? AppStyles.styleSemiBold16(context)
                      : AppStyles.styleRegular16(context),
                ),
                selected: selectedIndex == 0,
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.warehouse,
                  color: selectedIndex == 1 ? Colors.blue : Colors.grey,
                ),
                title: Text(
                  'المخازن',
                  style: selectedIndex == 1
                      ? AppStyles.styleSemiBold16(context)
                      : AppStyles.styleRegular16(context),
                ),
                selected: selectedIndex == 1,
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.category,
                  color: selectedIndex == 2 ? Colors.blue : Colors.grey,
                ),
                title: Text(
                  'الاصناف',
                  style: selectedIndex == 2
                      ? AppStyles.styleSemiBold16(context)
                      : AppStyles.styleRegular16(context),
                ),
                selected: selectedIndex == 2,
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.storefront,
                  color: selectedIndex == 3 ? Colors.blue : Colors.grey,
                ),
                title: Text(
                  'المنتجات',
                  style: selectedIndex == 3
                      ? AppStyles.styleSemiBold16(context)
                      : AppStyles.styleRegular16(context),
                ),
                selected: selectedIndex == 3,
                onTap: () {
                  setState(() {
                    selectedIndex = 3;
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.bar_chart,
                  color: selectedIndex == 4 ? Colors.blue : Colors.grey,
                ),
                title: Text(
                  'احصائيات ',
                  style: selectedIndex == 4
                      ? AppStyles.styleSemiBold16(context)
                      : AppStyles.styleRegular16(context),
                ),
                selected: selectedIndex == 4,
                onTap: () {
                  setState(() {
                    selectedIndex = 4;
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.attach_money,
                  color: selectedIndex == 5 ? Colors.blue : Colors.grey,
                ),
                title: Text(
                  'المالية',
                  style: selectedIndex == 5
                      ? AppStyles.styleSemiBold16(context)
                      : AppStyles.styleRegular16(context),
                ),
                selected: selectedIndex == 5,
                onTap: () {
                  setState(() {
                    selectedIndex = 5;
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: selectedIndex == 6 ? Colors.blue : Colors.grey,
                ),
                title: Text(
                  'حسابي',
                  style: selectedIndex == 6
                      ? AppStyles.styleSemiBold16(context)
                      : AppStyles.styleRegular16(context),
                ),
                selected: selectedIndex == 6,
                onTap: () {
                  setState(() {
                    selectedIndex = 6;
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
            'إدارة المتاجر',
            style: AppStyles.styleSemiBold18(context),
          ),
        ),
        body: SafeArea(child: widgets.elementAt(selectedIndex)),
      ),
    );
  }
}
