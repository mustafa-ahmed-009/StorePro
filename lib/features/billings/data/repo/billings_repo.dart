import 'package:dartz/dartz.dart';
import 'package:shops_manager_offline/core/config/failures.dart';
import 'package:shops_manager_offline/core/config/sqflite_data_base_failure.dart';
import 'package:shops_manager_offline/features/billings/data/data_source/billing_data_source.dart';
import 'package:shops_manager_offline/features/billings/data/models/billing_model.dart';

class BillingRepo {
  final BillingDataSource _dataSource = BillingDataSource();

  // Add a new billing record
  Future<Either<Failure, int>> addBilling(BillingModel billing) async {
    try {
      final result = await _dataSource.addBilling(billing);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  // Fetch all billing records
  Future<Either<Failure, List<BillingModel>>> fetchBills() async {
    try {
      final result = await _dataSource.getBillings();
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  // Fetch billing records for a specific date
  Future<Either<Failure, List<BillingModel>>> fetchBillsByDate({
    required String date,
  }) async {
    try {
      final result = await _dataSource.getBillingsByDate(date: date);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  // Fetch billing records for a specific month
  Future<Either<Failure, List<BillingModel>>> fetchBillsByMonth({
    required String month,
  }) async {
    try {
      final result = await _dataSource.getBillingsByMonth(month: month);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  // Update a billing record
  Future<Either<Failure, int>> updateBilling(BillingModel billing) async {
    try {
      final result = await _dataSource.updateBilling(billing);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  // Delete a billing record
  Future<Either<Failure, int>> deleteBilling(int id) async {
    try {
      final result = await _dataSource.deleteBilling(id);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }
}