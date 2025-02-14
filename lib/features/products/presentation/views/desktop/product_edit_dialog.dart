import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/functions/shared_preferences.dart';
import 'package:shops_manager_offline/core/functions/show_error_snack_bar.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/products/data/models/product_model.dart';
import 'package:shops_manager_offline/features/products/presentation/manager/cubit/products_cubit.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/managers/cubit/warehouses_cubit.dart';

void showEditProductDialog({
  required BuildContext context,
  required ProductsCubit productsCubit,
  required ProductModel product,
}) async{
  final nameController = TextEditingController(text: product.name);
  final traderPriceController =
      TextEditingController(text: product.traderPrice.toString());
  final customerPriceController =
      TextEditingController(text: product.customerPrice.toString());
  final barcodeController = TextEditingController(text: product.barcode);
  final quantityController =
      TextEditingController(text: product.wareHouseQuantity.toString());
  final colorController = TextEditingController(text: product.color ?? '');
  final criticalQuantityController =
      TextEditingController(text: product.criticalQuantity.toString());

  // State variable for the selected size
  String? selectedSize = product.size;

  // List of available sizes
  final List<String> sizes = [
    'XXS',
    'XS',
    'S',
    'M',
    'L',
    'Xl',
    'XXl',
    'XXXl',
    'XXXXl',
  ];
    final admin = await isAdmin();
    admin ? 
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(
              'تعديل المنتج',
              style: AppStyles.styleSemiBold20(context),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Product Name TextField
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'اسم المنتج',
                      labelStyle: AppStyles.styleRegular16(context),
                    ),
                  ),

                  // Trader Price TextField
                  TextField(
                    controller: traderPriceController,
                    decoration: InputDecoration(
                      labelText: 'سعر التاجر',
                      labelStyle: AppStyles.styleRegular16(context),
                    ),
                    keyboardType: TextInputType.number,
                  ),

                  // Customer Price TextField
                  TextField(
                    controller: customerPriceController,
                    decoration: InputDecoration(
                      labelText: 'سعر العميل',
                      labelStyle: AppStyles.styleRegular16(context),
                    ),
                    keyboardType: TextInputType.number,
                  ),

                  // Barcode TextField
                  TextField(
                    controller: barcodeController,
                    decoration: InputDecoration(
                      labelText: 'الباركود',
                      labelStyle: AppStyles.styleRegular16(context),
                    ),
                    keyboardType: TextInputType.text,
                  ),

                  // Quantity TextField
                  TextField(
                    controller: quantityController,
                    decoration: InputDecoration(
                      labelText: 'الكمية',
                      labelStyle: AppStyles.styleRegular16(context),
                    ),
                    keyboardType: TextInputType.number,
                  ),

                  // Color TextField (optional)
                  TextField(
                    controller: colorController,
                    decoration: InputDecoration(
                      labelText: 'اللون (اختياري)',
                      labelStyle: AppStyles.styleRegular16(context),
                    ),
                    keyboardType: TextInputType.text,
                  ),

                  // Critical Quantity TextField (required)
                  TextField(
                    controller: criticalQuantityController,
                    decoration: InputDecoration(
                      labelText: 'الكمية الحرجة',
                      labelStyle: AppStyles.styleRegular16(context),
                    ),
                    keyboardType: TextInputType.number,
                  ),

                  // Size Dropdown
                  DropdownButton<String>(
                    value: selectedSize,
                    hint: Text(
                      'اختار الحجم',
                      style: AppStyles.styleRegular16(context),
                    ),
                    items: sizes.map((size) {
                      return DropdownMenuItem<String>(
                        value: size,
                        child: Text(
                          size,
                          style: AppStyles.styleRegular16(context),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // Update the selected size and rebuild the UI
                      setState(() {
                        selectedSize = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text(
                  'إلغاء',
                  style: AppStyles.styleRegular16(context),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final name = nameController.text.trim();
                  final traderPrice =
                      double.tryParse(traderPriceController.text.trim());
                  final customerPrice =
                      double.tryParse(customerPriceController.text.trim());
                  final barcode = barcodeController.text.trim();
                  final quantity = int.tryParse(quantityController.text.trim());
                  final color = colorController.text.trim();
                  final criticalQuantity =
                      int.tryParse(criticalQuantityController.text.trim());

                  if (name.isNotEmpty &&
                      traderPrice != null &&
                      customerPrice != null &&
                      barcode.isNotEmpty &&
                      quantity != null &&
                      criticalQuantity != null) {
                    // Create the updated product
                    final updatedProduct = product.copyWith(
                      name: name,
                      traderPrice: traderPrice,
                      customerPrice: customerPrice,
                      barcode: barcode,
                      wareHouseQuantity: quantity,
                      color: color.isNotEmpty ? color : null,
                      criticalQuantity: criticalQuantity,
                      size: selectedSize, // Pass the updated size
                    );

                    // Update the warehouse quantity
                    await WarehouseCubit().updateWarehouse(
                      wareHouseId: product.warehouseId,
                      additionalQuantity: -(product.wareHouseQuantity),
                    );

                    // Update the product
                    await productsCubit.updateProduct(updatedProduct);

                    // Update the warehouse quantity with the new quantity
                    await WarehouseCubit().updateWarehouse(
                      wareHouseId: product.warehouseId,
                      additionalQuantity: quantity,
                    );

                    if (context.mounted) {
                      Navigator.pop(context); // Close the dialog
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'الرجاء إدخال جميع الحقول بشكل صحيح.',
                          style: AppStyles.styleRegular16(context),
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  'حفظ',
                  style: AppStyles.styleSemiBold16(context),
                ),
              ),
            ],
          );
        },
      );
    },
  ): showErrorSnackBar(
            context, "عذرا ليس لديك صلاحيات القيام بتلك العملية ");
}
