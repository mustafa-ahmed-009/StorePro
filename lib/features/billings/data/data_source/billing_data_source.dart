
import 'package:shops_manager_offline/core/config/data_base_helper.dart';
import 'package:shops_manager_offline/features/billings/data/models/billing_model.dart';

class BillingDataSource {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Add a new billing record
  Future<int> addBilling(BillingModel billingModel) async {
    final db = await _dbHelper.database;
    int billingId = await db.insert('billing', billingModel.toMap());
    return billingId;
  }

  // Fetch all billing records
  Future<List<BillingModel>> getBillings() async {
    final db = await _dbHelper.database;
    final result = await db.query('billing');
    List<BillingModel> bills = result.map((e) => BillingModel.fromMap(e)).toList();
    return bills;
  }

  // Fetch billing records for a specific date
  Future<List<BillingModel>> getBillingsByDate({required String date}) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'billing',
      where: "created_at LIKE ?",
      whereArgs: ['$date%'],
    );
    List<BillingModel> bills = result.map((e) => BillingModel.fromMap(e)).toList();
    return bills;
  }

  // Fetch billing records for a specific month
  Future<List<BillingModel>> getBillingsByMonth({required String month}) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'billing',
      where: "created_at LIKE ?",
      whereArgs: ['$month-%'],
    );
    List<BillingModel> bills = result.map((e) => BillingModel.fromMap(e)).toList();
    return bills;
  }

  // Update a billing record
  Future<int> updateBilling(BillingModel billingModel) async {
    final db = await _dbHelper.database;
    return await db.update(
      'billing',
      billingModel.toMap(),
      where: 'id = ?',
      whereArgs: [billingModel.id],
    );
  }

  // Delete a billing record
  Future<int> deleteBilling(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'billing',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}