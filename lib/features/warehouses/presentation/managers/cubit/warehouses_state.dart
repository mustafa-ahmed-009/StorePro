part of 'warehouses_cubit.dart';

@immutable

sealed class WarehouseState {}

final class WarehouseInitial extends WarehouseState {}

final class WarehouseLoading extends WarehouseState {}

final class WarehouseSuccess extends WarehouseState {
  final List<WarehouseModel> warehouses;

  WarehouseSuccess({required this.warehouses});
}

final class WarehouseFailure extends WarehouseState {
  final String errorMessage;

  WarehouseFailure({required this.errorMessage});
}
