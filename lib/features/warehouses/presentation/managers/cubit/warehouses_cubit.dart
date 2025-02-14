import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shops_manager_offline/features/warehouses/data/models/warehouses_model.dart';
import 'package:shops_manager_offline/features/warehouses/data/repo/warehouses_repo.dart';

part 'warehouses_state.dart';

class WarehouseCubit extends Cubit<WarehouseState> {
  WarehouseCubit() : super(WarehouseInitial());

  final WarehouseRepo _repo = WarehouseRepo();

  Future<void> fetchWarehouses() async {
    if (!isClosed) emit(WarehouseLoading());
    final result = await _repo.fetchWareHouses();
    result.fold(
      (errorMessage) {
        if (!isClosed) emit(WarehouseFailure(errorMessage: errorMessage.errMessage));
      },
      (warehouses) {
        if (!isClosed) emit(WarehouseSuccess(warehouses: warehouses));
      },
    );
  }

Future<void> addWarehouse(String name) async {
  if (!isClosed) emit(WarehouseLoading());
  final warehouse = WarehouseModel(name: name); // Do not set the id
  final result = await _repo.addWarehouse(warehouse);
  result.fold(
    (errorMessage) {
      if (!isClosed) emit(WarehouseFailure(errorMessage: errorMessage.errMessage));
    },
    (_) {
      if (!isClosed) fetchWarehouses(); // Refresh the list after adding
    },
  );
}

  Future<void> updateWarehouse({ required int wareHouseId , required int additionalQuantity}) async {
    if (!isClosed) emit(WarehouseLoading());
    final result = await _repo.updateWarehouse(wareHouseId: wareHouseId , additionalQuantity: additionalQuantity);
    result.fold(
      (errorMessage) {
        if (!isClosed) emit(WarehouseFailure(errorMessage: errorMessage.errMessage));
      },
      (_) {
        if (!isClosed) fetchWarehouses(); // Refresh the list after updating
      },
    );
  }

  Future<void> deleteWarehouse(int id) async {
    if (!isClosed) emit(WarehouseLoading());
    final result = await _repo.deleteWarehouse(id);
    result.fold(
      (errorMessage) {
        if (!isClosed) emit(WarehouseFailure(errorMessage: errorMessage.errMessage));
      },
      (_) {
        if (!isClosed) fetchWarehouses(); // Refresh the list after deleting
      },
    );
  }
}