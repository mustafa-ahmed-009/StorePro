import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/categories/presentation/managers/cubit/categories_cubit.dart';
import 'package:shops_manager_offline/features/products/data/models/product_model.dart';
import 'package:shops_manager_offline/features/products/presentation/manager/cubit/products_cubit.dart';
import 'package:shops_manager_offline/features/warehouses/presentation/managers/cubit/warehouses_cubit.dart';

void showAddProductDialog({
  required BuildContext context,
  required ProductsCubit productsCubit,
  required WarehouseCubit warehouseCubit,
  required CategoriesCubit categoriesCubit,
}) {
  final nameController = TextEditingController();
  final traderPriceController = TextEditingController();
  final customerPriceController = TextEditingController();
  final quantityController = TextEditingController();
  final barcodeController = TextEditingController(
      text: generateCode128Barcode()); // Auto-generate Code 128 barcode
  final colorController = TextEditingController(); // New controller for color
  final criticalQuantityController =
      TextEditingController(); // New controller for critical quantity

  int? selectedWarehouseId;
  int? selectedCategoryId;
  String? selectedSize; // Variable to store the selected size

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

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(
              'إضافة منتج',
              style: AppStyles.styleSemiBold20(context),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Warehouse Dropdown
                  BlocBuilder<WarehouseCubit, WarehouseState>(
                    bloc: warehouseCubit,
                    builder: (context, warehouseState) {
                      if (warehouseState is WarehouseLoading) {
                        return const CircularProgressIndicator();
                      } else if (warehouseState is WarehouseFailure) {
                        return Text(
                          'خطأ: ${warehouseState.errorMessage}',
                          style: AppStyles.styleRegular16(context),
                        );
                      } else if (warehouseState is WarehouseSuccess) {
                        final warehouses = warehouseState.warehouses;
                        return DropdownButton<int>(
                          value: selectedWarehouseId,
                          hint: Text(
                            'اختار المخزن',
                            style: AppStyles.styleRegular16(context),
                          ),
                          items: warehouses.map((warehouse) {
                            return DropdownMenuItem<int>(
                              value: warehouse.id,
                              child: Text(
                                warehouse.name,
                                style: AppStyles.styleRegular16(context),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedWarehouseId = value;
                              selectedCategoryId =
                                  null; // Reset category when warehouse changes
                              if (value != null) {
                                categoriesCubit
                                    .filterCategoriesByWarehouse(value);
                              }
                            });
                          },
                        );
                      } else {
                        return Text(
                          'لم يتم العثور على مخازن',
                          style: AppStyles.styleRegular16(context),
                        );
                      }
                    },
                  ),

                  // Category Dropdown (only shown if a warehouse is selected)
                  if (selectedWarehouseId != null)
                    BlocBuilder<CategoriesCubit, CategoriesState>(
                      bloc: categoriesCubit,
                      builder: (context, categoriesState) {
                        if (categoriesState is CategoriesLoading) {
                          return const CircularProgressIndicator();
                        } else if (categoriesState is CategoriesFailure) {
                          return Text(
                            'خطأ: ${categoriesState.errorMessage}',
                            style: AppStyles.styleRegular16(context),
                          );
                        } else if (categoriesState is CategoriesSuccess) {
                          final categories = categoriesState.categories
                              .where((category) =>
                                  category.warehouseId == selectedWarehouseId)
                              .toList();
                          return DropdownButton<int>(
                            value: selectedCategoryId,
                            hint: Text(
                              'اختار الصنف',
                              style: AppStyles.styleRegular16(context),
                            ),
                            items: categories.map((category) {
                              return DropdownMenuItem<int>(
                                value: category.id,
                                child: Text(
                                  category.name,
                                  style: AppStyles.styleRegular16(context),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCategoryId = value;
                              });
                            },
                          );
                        } else {
                          return Text(
                            'لم يتم العثور على أصناف',
                            style: AppStyles.styleRegular16(context),
                          );
                        }
                      },
                    ),

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

                  // Barcode TextField (pre-filled with auto-generated Code 128 barcode)
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

                  // Color TextField (nullable)
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
                      print(value);
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
                  final color = colorController.text.trim(); // Get color
                  final criticalQuantity = int.tryParse(
                      criticalQuantityController.text
                          .trim()); // Get critical quantity
                  if (name.isNotEmpty &&
                      selectedWarehouseId != null &&
                      selectedCategoryId != null &&
                      traderPrice != null &&
                      customerPrice != null &&
                      barcode.isNotEmpty &&
                      quantity != null &&
                      criticalQuantity != null &&
                      selectedSize != null) {
                    // Ensure size is selected
                    // Create the product
                    final product = ProductModel(
                      name: name,
                      warehouseId: selectedWarehouseId!,
                      categoryId: selectedCategoryId!,
                      traderPrice: traderPrice,
                      customerPrice: customerPrice,
                      barcode: barcode,
                      wareHouseQuantity: quantity,
                      color: color.isNotEmpty
                          ? color
                          : null, // Set color (nullable)
                      criticalQuantity:
                          criticalQuantity, // Set critical quantity
                      size: selectedSize!, // Set size
                    );
                    // Add the product using the cubit
                    productsCubit.addProduct(product);
                    warehouseCubit.updateWarehouse(
                      wareHouseId: product.warehouseId,
                      additionalQuantity: quantity,
                    );

                    Navigator.pop(context); // Close the dialog
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
                  'إضافة',
                  style: AppStyles.styleSemiBold16(context),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

String generateCode128Barcode() {
  // Generate a unique barcode string (e.g., using a timestamp and random number)
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final randomNumber =
      Random().nextInt(9000) + 1000; // Random number between 1000 and 9999
  final barcodeData = '$timestamp-$randomNumber';

  // Generate the Code 128 barcode
  return barcodeData;
}
