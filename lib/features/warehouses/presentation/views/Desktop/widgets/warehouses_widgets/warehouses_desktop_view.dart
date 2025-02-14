import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/functions/check_if_is_admin.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/managers/cubit/warehouses_cubit.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/views/Desktop/widgets/warehouses_widgets/add_warehosue_dialog.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/views/Desktop/widgets/warehouses_widgets/warehosue_grid_view_builder.dart';

class WareHouseDekstopView extends StatelessWidget {
  const WareHouseDekstopView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WarehouseCubit()..fetchWarehouses(),
      child: BlocBuilder<WarehouseCubit, WarehouseState>(
        builder: (context, state) {
          if (state is WarehouseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WarehouseSuccess) {
            final WarehouseCubit warehouseCubit =
                context.read<WarehouseCubit>();
                
            return Column(
              children: [
                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      checkAdminAndShowDialog<WarehouseCubit>(
                        context: context,
                        cubit:
                            warehouseCubit, // Use the existing cubit instance
                        showDialogCallback: (context, cubit) {
                          _showAddWarehouseDialog(
                            context: context,
                            warehouseCubit:
                                cubit, // Pass the cubit from the callback
                          );
                        },
                      );
                    }),
                state.warehouses.isEmpty
                    ? Text(
                        "لايوجد مخازن اللي الان برجاء اضافة مخزن اذا كنت تمتلك الصلاحيات المناسبة",
                        style: AppStyles.styleMedium20(context),
                      )
                    : Expanded(
                        child: WareHouseGridViewBuilder(
                            crossAxisCount: 4, warehouses: state.warehouses)),
              ],
            );
          } else if (state is WarehouseFailure) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  void _showAddWarehouseDialog(
      {required BuildContext context, required WarehouseCubit warehouseCubit}) {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AddWarehouseDialog(
          nameController: nameController,
          warehouseCubit: warehouseCubit,
        );
      },
    );
  }
}
