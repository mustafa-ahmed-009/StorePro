import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/products/presentation/manager/cubit/products_cubit.dart';

class SearchBarProductDetailsView extends StatelessWidget {
  const SearchBarProductDetailsView({super.key, required this.productId});
  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductsCubit()..fetchProductById(productId: productId),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "بيانات المنتج",
              style: AppStyles.styleSemiBold20(context),
            ),
          ),
          body: BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              if (state is PrdocutDetailsLoadingSuccess) {
                final productModel = state.product;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow("الاسم", productModel.name, context),
                        _buildDetailRow(
                            "الباركود", productModel.barcode, context),
                        _buildDetailRow("المخزن",
                            productModel.warehouseName ?? "غير محدد", context),
                        _buildDetailRow("الفئة",
                            productModel.categoryName ?? "غير محدد", context),
                        _buildDetailRow("سعر التاجر",
                            "${productModel.traderPrice}", context),
                        _buildDetailRow("سعر العميل",
                            "${productModel.customerPrice}", context),
                        _buildDetailRow("الكمية في المخزن",
                            "${productModel.wareHouseQuantity}", context),
                        _buildDetailRow("الكمية الحرجة",
                            "${productModel.criticalQuantity}", context),
                        _buildDetailRow(
                            "اللون", productModel.color ?? "غير محدد", context),
                        _buildDetailRow("الكمية في الفاتورة",
                            "${productModel.billQuantity}", context),
                      ],
                    ),
                  ),
                );
              } else if (state is ProductsFailure) {
                return Center(
                  child: Text(
                    state.errMessage,
                    style: AppStyles.styleRegular16(context),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // Helper method to build a detail row
  Widget _buildDetailRow(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppStyles.styleSemiBold16(context),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppStyles.styleRegular16(context),
            ),
          ),
        ],
      ),
    );
  }
}
