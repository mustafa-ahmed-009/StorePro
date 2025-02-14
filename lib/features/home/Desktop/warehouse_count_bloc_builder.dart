import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/managers/cubit/warehouses_cubit.dart';

class WarehousesCountBlocbuilder extends StatelessWidget {
  const WarehousesCountBlocbuilder({
    super.key,
    required this.warehouseCubit,
  });

  final WarehouseCubit warehouseCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: warehouseCubit,
      child: BlocBuilder<WarehouseCubit, WarehouseState>(
        builder: (context, state) {
          if (state is WarehouseSuccess) {
            return Column(
              spacing: 12,
              children: [
                Text(
                  "احصائيات المخازن",
                  style: AppStyles.styleMedium20(context),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // Prevent scrolling conflicts

                  itemCount: state.warehouses.length,
                  itemBuilder: (context, index) {
                    final warehouse = state.warehouses[index];
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5), // Add spacing between items
                      padding:
                          EdgeInsets.all(12), // Add padding inside each item
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50, // Light blue background
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                        border: Border.all(
                          color: Colors.blue.shade200, // Border color
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "مخزن ${warehouse.name}: ",
                            style: AppStyles.styleSemiBold16(
                                context), // Use AppStyles
                          ),
                          const SizedBox(width: 8), // Add spacing between texts
                          Text(
                            "عدد المنتجات الحالي: ${warehouse.productsCount}",
                            style: AppStyles.styleRegular16(
                                context), // Use AppStyles
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          } else if (state is WarehouseFailure) {
            return Center(
              child: Text(
                "حدث خطأ أثناء تحميل البيانات",
                style: AppStyles.styleSemiBold16(context)
                    .copyWith(color: Colors.red), // Use AppStyles
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(), // Show loading indicator
            );
          }
        },
      ),
    );
  }
}
