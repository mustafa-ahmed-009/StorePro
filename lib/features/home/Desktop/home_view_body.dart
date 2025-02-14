import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shops_manager_offline/features/billings/presentation/managers/cubit/bill_cubit.dart';
import 'package:shops_manager_offline/features/home/Desktop/home_view_bill_adding_button.dart';
import 'package:shops_manager_offline/features/home/Desktop/lastest_five_bills_list_bloc_builder.dart';
import 'package:shops_manager_offline/features/home/Desktop/search_bar_widgert.dart';
import 'package:shops_manager_offline/features/home/Desktop/warehouse_count_bloc_builder.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/managers/cubit/warehouses_cubit.dart';
import 'package:shops_manager_offline/main.dart';

class HomeScreenViewBody extends StatefulWidget {
  const HomeScreenViewBody({super.key});

  @override
  State<HomeScreenViewBody> createState() => _HomeScreenViewBodyState();
}

class _HomeScreenViewBodyState extends State<HomeScreenViewBody>
    with RouteAware {
  late BillCubit _billCubit;
  bool _isSubscribed = false; // Track subscription status

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log("didChangeDependencies called");

    // Ensure we only subscribe once
    if (!_isSubscribed) {
      var route = ModalRoute.of(context);
      if (route is PageRoute) {
        log("Subscribing to route observer");
        routeObserver.subscribe(this, route);
        _isSubscribed = true; // Mark as subscribed
      } else {
        log("No valid route found for subscription");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _billCubit = BillCubit();
    _billCubit.fetchRecentFiveBills();
  }

  @override
  void didPopNext() {
    log("did pop next called ");
    _billCubit.fetchRecentFiveBills();
  }

  @override
  void dispose() {
    log("Unsubscribing from route observer");
    routeObserver.unsubscribe(this); // Unsubscribe when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 12,
      children: [
        SearchBarWidget(
          hintText: " ابحث عن منتج في جميع المخازن ...",
        ),
        HomeVIewBillAddingButton(),
        //      WarehousesCountBlocbuilder(warehouseCubit: _warehouseCubit),
        Expanded(
          child: LastestFiveBillsListBlocBuilder(
            billCubit: _billCubit,
          ),
        ),
      ],
    );
  }
}
