import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/categories/presentation/managers/cubit/categories_cubit.dart';
import 'package:shops_manager_offline/features/products/data/models/product_model.dart';
import 'package:shops_manager_offline/features/products/presentation/manager/cubit/products_cubit.dart';
import 'package:shops_manager_offline/features/products/presentation/views/desktop/products_category_builder.dart';
import 'package:shops_manager_offline/features/products/presentation/views/desktop/warehouses_bloc_builder.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/managers/cubit/warehouses_cubit.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({super.key});

  @override
  State<StatefulWidget> createState() => StatisticsViewState();
}

class StatisticsViewState extends State<StatisticsView> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WarehouseCubit()..fetchWarehouses()),
        BlocProvider(create: (context) => CategoriesCubit()..fetchCategories()),
        BlocProvider(create: (context) => ProductsCubit()..fetchAllProducts()),
      ],
      child: Column(
        children: [
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              final productsCubit = context.read<ProductsCubit>();
              final filteredProducts = productsCubit.getFilteredProducts();
              final double total = getSoldItemTotal(filteredProducts);

              return Column(
                children: [
                  // Dropdowns for selecting warehouse and category
                  Row(
                    children: [
                      buildWarehouseDropdown(context, productsCubit),
                      if (productsCubit.selectedWarehouseId != null)
                        buildCategoryDropdown(context, productsCubit),
                    ],
                  ),
                  // Check if both warehouse and category are selected
                  if (productsCubit.selectedWarehouseId != null &&
                      productsCubit.selectedCategoryId != null) ...[
                    // Show the chart only when valid selections are made
                    filteredProducts.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "لا يوجد منتجات متاحة في الفئة المحددة.",
                              style: AppStyles.styleMedium20(context),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "الإحصائيات بناءً على الفئة والمخزن المختارين",
                                  style: AppStyles.styleMedium20(context),
                                ),
                                BarCharWidget(
                                  products: filteredProducts,
                                  total: total,
                                ),
                              ],
                            ),
                          ),
                  ] else
                    // Show a message to guide the user to select both
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "يرجى اختيار المخزن والفئة لعرض الإحصائيات.",
                        style: AppStyles.styleMedium20(context),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  double getSoldItemTotal(List<ProductModel> products) {
    double total = 0.0;
    for (var i = 0; i < products.length; i++) {
      total += products[i].soldQuantity;
    }
    return total;
  }
}

List<BarChartGroupData> showBars(List<ProductModel> products, double total) {
  // Sort products by soldQuantity in descending order
  products.sort((a, b) => a.soldQuantity.compareTo(b.soldQuantity));

  List<BarChartGroupData> charts = [];
  for (var i = 0; i < products.length; i++) {
    charts.add(BarChartGroupData(
      x: i, // Use the sorted index as position
      barRods: [
        BarChartRodData(toY: products[i].soldQuantity.toDouble(), width: 8),
      ],
    ));
  }
  return charts;
}

class BarCharWidget extends StatelessWidget {
  const BarCharWidget({super.key, required this.products, required this.total});
  final List<ProductModel> products;
  final double total;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3,
      child: BarChart(
        BarChartData(
          barGroups: showBars(products, total),
          groupsSpace: 60,
          alignment: BarChartAlignment.start,
          // Adjust spacing between bars
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < products.length) {
                    return Text(
                      "مقاس ${products[index].size}",
                      style: AppStyles.styleRegualr18(context),
                    );
                  }
                  return const SizedBox.shrink();
                },
                interval: 1, // Ensure one title per bar
              ),
            ),
          ),

          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  "${products[group.x.toInt()].name}\n",
                  const TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: rod.toY.toStringAsFixed(2),
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
