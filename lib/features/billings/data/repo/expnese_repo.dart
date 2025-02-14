import 'package:dartz/dartz.dart';
import 'package:shops_manager_offline/core/config/failures.dart';
import 'package:shops_manager_offline/core/config/sqflite_data_base_failure.dart';
import 'package:shops_manager_offline/features/billings/data/data_source/expense_data_source.dart';
import 'package:shops_manager_offline/features/billings/data/models/expenses.model.dart';

class ExpensesRepo {
  final ExpensesDataSource _dataSource = ExpensesDataSource();

  // Add a new expense record
  Future<Either<Failure, int>> addExpense(ExpensesModel expense) async {
    try {
      final result = await _dataSource.addExpense(expense);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  // Fetch all expense records
  Future<Either<Failure, List<ExpensesModel>>> fetchExpenses() async {
    try {
      final result = await _dataSource.getExpenses();
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  // Fetch expense records for a specific date
  Future<Either<Failure, List<ExpensesModel>>> fetchExpensesByDate({
    required String date,
  }) async {
    try {
      final result = await _dataSource.getExpensesByDate(date: date);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  // Fetch expense records for a specific month
  Future<Either<Failure, List<ExpensesModel>>> fetchExpensesByMonth({
    required String month,
  }) async {
    try {
      final result = await _dataSource.getExpensesByMonth(month: month);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  // Update an expense record
  Future<Either<Failure, int>> updateExpense(ExpensesModel expense) async {
    try {
      final result = await _dataSource.updateExpense(expense);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  // Delete an expense record
  Future<Either<Failure, int>> deleteExpense(int id) async {
    try {
      final result = await _dataSource.deleteExpense(id);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }
}