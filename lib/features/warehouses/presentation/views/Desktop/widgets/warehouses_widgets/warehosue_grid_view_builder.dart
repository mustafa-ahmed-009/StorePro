import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/functions/shared_preferences.dart';
import 'package:shops_manager_offline/core/functions/show_error_snack_bar.dart';
import 'package:shops_manager_offline/features/warehouses/data/models/warehouses_model.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/managers/cubit/warehouses_cubit.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/views/Desktop/widgets/warehouses_widgets/update_warehouse_dialog.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/views/Desktop/widgets/warehouses_widgets/delete_ware_house_dialog.dart'; // Import your AppStyles

class WareHouseGridViewBuilder extends StatelessWidget {
  final List<WarehouseModel> warehouses;
  final int crossAxisCount;
  const WareHouseGridViewBuilder(
      {super.key, required this.warehouses, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    final WarehouseCubit warehouseCubit = context.read<WarehouseCubit>();
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, // Number of columns
        crossAxisSpacing: 16, // Spacing between columns
        mainAxisSpacing: 16, // Spacing between rows
        childAspectRatio: 1.5, // Aspect ratio of each card
      ),
      padding: const EdgeInsets.all(16), // Padding around the grid
      itemCount: warehouses.length,
      itemBuilder: (context, index) {
        final warehouse = warehouses[index];
        return WarehouseCard(
          warehouse: warehouse,
          onTap: () {},
          onEdit: () =>
              _showUpdateWarehouseDialog(context, warehouse, warehouseCubit),
          onDelete: () =>
              _deleteWarehouse(context, warehouse.id!, warehouseCubit),
        );
      },
    );
  }

  void _showUpdateWarehouseDialog(BuildContext context,
      WarehouseModel warehouse, WarehouseCubit warehouseCubit) async {
    final nameController = TextEditingController(text: warehouse.name);
    final admin = await isAdmin();
    admin
        ? showDialog(
            context: context,
            builder: (context) {
              return UpdateWarehouseDialog(
                warehouseCubit: warehouseCubit,
                warehouse: warehouse,
                nameController: nameController,
              );
            },
          )
        : showErrorSnackBar(context,
            "عذرا انت لا تمتلك الصلاحيات المناسبة للقيام بتلك العملية");
  }

  void _deleteWarehouse(
      BuildContext context, int id, WarehouseCubit warehouseCubit) async {
    final admin = await isAdmin();
    admin
        ? showDialog(
            context: context,
            builder: (context) {
              return DeleteWarehouseDialog(
                id: id,
                warehouseCubit: warehouseCubit,
              );
            },
          )
        : showErrorSnackBar(context,
            "عذرا انت لا تمتلك الصلاحيات المناسبة للقيام بتلك العملية");
  }
}

class WarehouseCard extends StatelessWidget {
  final WarehouseModel warehouse;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const WarehouseCard({
    super.key,
    required this.warehouse,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Shadow depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: InkWell(
        onTap: onTap, // Navigate to categories screen
        borderRadius: BorderRadius.circular(12), // Match card's rounded corners
        child: Padding(
          padding: const EdgeInsets.all(16), // Padding inside the card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Warehouse Name
              Text(
                warehouse.name,
                style: AppStyles.styleSemiBold18(context), // Use AppStyles
                textAlign: TextAlign.center,
              ),

              const Spacer(), // Push buttons to the bottom
              // Edit and Delete Buttons
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.blue, // Edit icon color
                      ),
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.red, // Delete icon color
                      ),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
