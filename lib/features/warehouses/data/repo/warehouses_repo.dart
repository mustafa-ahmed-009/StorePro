import 'package:dartz/dartz.dart';
import 'package:shops_manager_offline/core/config/failures.dart';
import 'package:shops_manager_offline/core/config/sqflite_data_base_failure.dart';
import 'package:shops_manager_offline/features/warehouses/data/data_sources/warehouses_data_source.dart';
import 'package:shops_manager_offline/features/warehouses/data/models/warehouses_model.dart';

class WarehouseRepo {
  final WarehouseDataSource _dataSource = WarehouseDataSource();

  Future<Either<Failure, List<WarehouseModel>>> fetchWareHouses() async {
    try {
      final result = await _dataSource.getWarehouses();
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e)); // Use SqfliteDatabaseFailure
    }
  }

  Future<Either<Failure, int>> addWarehouse(WarehouseModel warehouse) async {
    try {
      final result = await _dataSource.addWarehouse(warehouse);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e)); // Use SqfliteDatabaseFailure
    }
  }

  Future<Either<Failure, int>> updateWarehouse({ required int wareHouseId , required int additionalQuantity}) async {
    try {
      final result = await _dataSource.updateWarehouse(wareHouseId: wareHouseId , additionalQuantity: additionalQuantity);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e)); // Use SqfliteDatabaseFailure
    }
  }

  Future<Either<Failure, int>> deleteWarehouse(int id) async {
    try {
      final result = await _dataSource.deleteWarehouse(id);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e)); // Use SqfliteDatabaseFailure
    }
  }

}
  Future<String> getProductWareHouseName(int ind) async {
  final warehouseName = await WarehouseDataSource().getWarehosueById(ind);
  return warehouseName;
}