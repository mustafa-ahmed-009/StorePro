
import 'package:shops_manager_offline/core/config/data_base_helper.dart';
import 'package:shops_manager_offline/features/billings/data/models/expenses.model.dart';

class ExpensesDataSource {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Add a new expense record
  Future<int> addExpense(ExpensesModel expenseModel) async {
    final db = await _dbHelper.database;
    int expenseId = await db.insert('expenses', expenseModel.toMap());
    return expenseId;
  }

  // Fetch all expense records
  Future<List<ExpensesModel>> getExpenses() async {
    final db = await _dbHelper.database;
    final result = await db.query('expenses');
    List<ExpensesModel> expenses = result.map((e) => ExpensesModel.fromMap(e)).toList();
    return expenses;
  }

  // Fetch expense records for a specific date
  Future<List<ExpensesModel>> getExpensesByDate({required String date}) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'expenses',
      where: "created_at LIKE ?",
      whereArgs: ['$date%'],
    );
    List<ExpensesModel> expenses = result.map((e) => ExpensesModel.fromMap(e)).toList();
    return expenses;
  }

  // Fetch expense records for a specific month
  Future<List<ExpensesModel>> getExpensesByMonth({required String month}) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'expenses',
      where: "created_at LIKE ?",
      whereArgs: ['$month-%'],
    );
    List<ExpensesModel> expenses = result.map((e) => ExpensesModel.fromMap(e)).toList();
    return expenses;
  }

  // Update an expense record
  Future<int> updateExpense(ExpensesModel expenseModel) async {
    final db = await _dbHelper.database;
    return await db.update(
      'expenses',
      expenseModel.toMap(),
      where: 'id = ?',
      whereArgs: [expenseModel.id],
    );
  }

  // Delete an expense record
  Future<int> deleteExpense(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}