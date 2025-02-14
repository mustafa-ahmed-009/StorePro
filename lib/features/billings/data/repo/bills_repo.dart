import 'package:dartz/dartz.dart';
import 'package:shops_manager_offline/core/config/failures.dart';
import 'package:shops_manager_offline/core/config/sqflite_data_base_failure.dart';
import 'package:shops_manager_offline/features/billings/data/data_source/bill_data_source.dart';
import 'package:shops_manager_offline/features/billings/data/models/bill_model.dart';
import 'package:shops_manager_offline/features/billings/data/models/bill_product_model.dart';
import 'package:shops_manager_offline/features/products/data/models/product_model.dart';

class BillsRepo {
  final BillDataSource _dataSource = BillDataSource();

  Future<Either<Failure, int>> addBill(BillModel bill) async {
    try {
      final result = await _dataSource.addBill(bill);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  Future<Either<Failure, void>> deleteBillAndBillProduct(
      {required int billId}) async {
    try {
      final result =
          await _dataSource.deleteBillAndItsBillProduct(billId: billId);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  Future<Either<Failure, List<BillModel>>> fetchBillsByDate(
      {required String currentDate}) async {
    try {
      final result = await _dataSource.getBills(currentDate: currentDate);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  Future<Either<Failure, List<BillModel>>> getRecentFiveBills() async {
    try {
      final result = await _dataSource.getRecentBills();
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  Future<Either<Failure, List<BillModel>>> fetchMonthlyBills(
      {required String month}) async {
    try {
      final result = await _dataSource.getBillsByMonth(month: month);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  Future<Either<Failure, List<BillProductModel>>> fetchBillPrdocuts(
      {required int billId}) async {
    try {
      final result = await _dataSource.getBillProducts(billId: billId);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  Future<Either<Failure, int>> addBillProduct(
      BillProductModel billProductModel) async {
    try {
      final result = await _dataSource.addBillProduct(billProductModel);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  Future<Either<Failure, ProductModel>> fetchProductByBarcode(
      {required String barcode}) async {
    try {
      final result = await _dataSource.getProductByBarCode(barcode: barcode);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }
}
