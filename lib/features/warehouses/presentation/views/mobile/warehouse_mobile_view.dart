import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/managers/cubit/warehouses_cubit.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/views/Desktop/widgets/warehouses_widgets/add_warehosue_dialog.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/views/Desktop/widgets/warehouses_widgets/warehosue_grid_view_builder.dart';

class WarehouseMobileView extends StatelessWidget {
  const WarehouseMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => WarehouseCubit()..fetchWarehouses(),
      child: Builder(
        builder: (context) => BlocBuilder<WarehouseCubit, WarehouseState>(
          builder: (context, state) {
            if (state is WarehouseLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WarehouseSuccess) {
              final WarehouseCubit warehouseCubit =
                  context.read<WarehouseCubit>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: WareHouseGridViewBuilder(
                          crossAxisCount: 2, warehouses: state.warehouses)),
                  ElevatedButton(
                    onPressed: () => _showAddWarehouseDialog(
                        context: context, warehouseCubit: warehouseCubit),
                    child: Text("اضافة مخزن"),
                  ),
                  SizedBox(
                    height: 10,
                  )
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
      ),
    ));
  }
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
