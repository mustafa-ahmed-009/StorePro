import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/functions/shared_preferences.dart';
import 'package:shops_manager_offline/core/functions/show_error_snack_bar.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/products/data/models/product_model.dart';
import 'package:shops_manager_offline/features/products/presentation/manager/cubit/products_cubit.dart';
import 'package:shops_manager_offline/features/products/presentation/views/desktop/product_edit_dialog.dart';
import 'package:shops_manager_offline/features/products/presentation/views/desktop/product_show_delete_dialog.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/managers/cubit/warehouses_cubit.dart';

Widget buildProductList(
  BuildContext context,
  List<ProductModel> filteredProducts,
  ProductsCubit productsCubit,
) {
  return Expanded(
    child: ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 4, // Add shadow to the card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
                vertical: 12, horizontal: 16), // Add padding
            title: Text(
              product.name,
              style: AppStyles.styleMedium16(context).copyWith(
                fontWeight: FontWeight.bold, // Make the title bold
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'المخزن: ${product.warehouseName}',
                  style: AppStyles.styleRegular14(context),
                ),
                Text(
                  'الصنف: ${product.categoryName!}',
                  style: AppStyles.styleRegular14(context),
                ),
                Text(
                  'السعر: ${product.customerPrice}',
                  style: AppStyles.styleBold16(context),
                ),
                Text(
                  'الكمية: ${product.wareHouseQuantity}',
                  style: AppStyles.styleBold16(context).copyWith(
                    fontWeight:
                        FontWeight.bold, // Make the warehouse quantity bold
                  ),
                ),
                Text(
                  'اللون: ${product.color ?? "لا يوجد لون"}',
                  style: AppStyles.styleRegular14(context),
                ),
                Text(
                  'المقاس: ${product.size}',
                  style: AppStyles.styleRegular14(context),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit,
                      color: Colors.blue), // Add color to the edit icon
                  onPressed: () =>
                      _openEditProductDialog(context, productsCubit, product),
                ),
                IconButton(
                  icon: const Icon(Icons.delete,
                      color: Colors.red), // Add color to the delete icon
                  onPressed: () async {
                    final admin = await isAdmin();
                    if (admin) {
                      bool confirmDelete = await showDeleteDialog(context);
                      // If the user confirmed the delete operation
                      if (confirmDelete == true) {
                        productsCubit.deleteProduct(product.id!);
                        WarehouseCubit().updateWarehouse(
                          wareHouseId: product.warehouseId,
                          additionalQuantity: -product.wareHouseQuantity,
                        );
                      }
                    } else {
                      showErrorSnackBar(context,
                          "عذرًا، ليس لديك صلاحيات للقيام بهذه العملية");
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

/// Opens the edit product dialog.
void _openEditProductDialog(
  BuildContext context,
  ProductsCubit productsCubit,
  ProductModel product,
) {
  showEditProductDialog(
    context: context,
    productsCubit: productsCubit,
    product: product,
  );
}
