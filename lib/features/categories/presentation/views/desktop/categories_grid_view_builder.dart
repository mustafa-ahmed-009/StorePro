import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/functions/shared_preferences.dart';
import 'package:shops_manager_offline/core/functions/show_error_snack_bar.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/categories/data/models/categories_models.dart';
import 'package:shops_manager_offline/features/categories/presentation/managers/cubit/categories_cubit.dart';

class CategoriesGridViewBuilder extends StatelessWidget {
  final int crossAxisCount;
  final List<CategoriesModel> categories;
  final CategoriesCubit categoriesCubit;

  const CategoriesGridViewBuilder({
    super.key,
    required this.crossAxisCount,
    required this.categories,
    required this.categoriesCubit,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 2,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category.name,
                  style:
                      AppStyles.styleSemiBold18(context), // استخدام AppStyles
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // زر التعديل
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // عرض مربع حوار التعديل
                        _showEditCategoryDialog(
                          context: context,
                          category: category,
                          categoriesCubit: categoriesCubit,
                        );
                      },
                    ),
                    // زر الحذف
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // عرض مربع حوار تأكيد الحذف
                        _showDeleteConfirmationDialog(
                          context: context,
                          categoryId: category.id!,
                          categoriesCubit: categoriesCubit,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // عرض مربع حوار لتعديل اسم الفئة
  void _showEditCategoryDialog({
    required BuildContext context,
    required CategoriesModel category,
    required CategoriesCubit categoriesCubit,
  }) async {
    final nameController = TextEditingController(text: category.name);
    final admin = await isAdmin();
    admin
        ? showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'تعديل الفئة',
                  style:
                      AppStyles.styleSemiBold20(context), // استخدام AppStyles
                ),
                content: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'اسم الفئة',
                    labelStyle:
                        AppStyles.styleRegular16(context), // استخدام AppStyles
                  ),
                  style: AppStyles.styleRegular16(context), // استخدام AppStyles
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // إغلاق مربع الحوار
                    },
                    child: Text(
                      'إلغاء',
                      style: AppStyles.styleRegular16(
                          context), // استخدام AppStyles
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      final newName = nameController.text.trim();
                      if (newName.isNotEmpty) {
                        // تحديث الفئة
                        final updatedCategory =
                            category.copyWith(name: newName);
                        categoriesCubit.updateCategory(updatedCategory);
                        Navigator.pop(context); // إغلاق مربع الحوار
                      } else {
                        // عرض خطأ إذا كان الاسم فارغًا
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'الرجاء إدخال اسم فئة صالح.',
                              style: AppStyles.styleRegular16(
                                  context), // استخدام AppStyles
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'حفظ',
                      style: AppStyles.styleSemiBold16(
                          context), // استخدام AppStyles
                    ),
                  ),
                ],
              );
            },
          )
        : showErrorSnackBar(
            context, "عذرا ليس لديك صلاحيات القيام بتلك العملية ");
  }

  // عرض مربع حوار تأكيد قبل حذف الفئة
  void _showDeleteConfirmationDialog({
    required BuildContext context,
    required int categoryId,
    required CategoriesCubit categoriesCubit,
  }) async {
    final admin = await isAdmin();
    admin
        ? showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'حذف الفئة',
                  style:
                      AppStyles.styleSemiBold20(context), // استخدام AppStyles
                ),
                content: Text(
                  'هل أنت متأكد أنك تريد حذف هذه الفئة؟',
                  style: AppStyles.styleRegular16(context), // استخدام AppStyles
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // إغلاق مربع الحوار
                    },
                    child: Text(
                      'إلغاء',
                      style: AppStyles.styleRegular16(
                          context), // استخدام AppStyles
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // حذف الفئة
                      categoriesCubit.deleteCategory(categoryId);
                      Navigator.pop(context); // إغلاق مربع الحوار
                    },
                    child: Text(
                      'حذف',
                      style: AppStyles.styleSemiBold16(
                          context), // استخدام AppStyles
                    ),
                  ),
                ],
              );
            },
          )
        : showErrorSnackBar(
            context, "عذرا ليس لديك صلاحيات القيام بتلك العملية ");
  }
}
