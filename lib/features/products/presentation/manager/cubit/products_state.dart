part of 'products_cubit.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsSuccess extends ProductsState {
  final List<ProductModel> products;
  ProductsSuccess(this.products);
}
class PrdocutDetailsLoadingSuccess extends ProductsState {
  final ProductModel product;
  PrdocutDetailsLoadingSuccess(this.product);
}
class ProductsFailure extends ProductsState {
  final String errMessage;
  ProductsFailure(this.errMessage);
}