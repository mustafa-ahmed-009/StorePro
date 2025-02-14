import 'package:shops_manager_offline/core/config/data_base_helper.dart';
import 'package:shops_manager_offline/features/billings/data/models/bill_model.dart';
import 'package:shops_manager_offline/features/billings/data/models/bill_product_model.dart';
import 'package:shops_manager_offline/features/products/data/models/product_model.dart';
import 'package:shops_manager_offline/features/warehouses/data/data_sources/warehouses_data_source.dart';

class BillDataSource {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Future<int> addBill(BillModel billModel) async {
    final db = await _dbHelper.database;
    int billId = await db.insert('bills', billModel.toMap());
    return billId;
  }

  Future<int> addBillProduct(BillProductModel billProductModel) async {
    final db = await _dbHelper.database;
    return await db.insert('bill_products', billProductModel.toMap());
  }

  Future<List<BillModel>> getBills({required String currentDate}) async {
    final db = await _dbHelper.database;
    final result = await db.query('bills',
        where: "created_at LIKE ?", whereArgs: ['$currentDate%']);
    List<BillModel> bills = result.map((e) => BillModel.fromMap(e)).toList();
    return bills;
  }

  Future<List<BillModel>> getBillsByMonth({required String month}) async {
    final db = await _dbHelper.database;

    String monthPattern = '$month-%';

    final result = await db.query(
      'bills',
      where: "created_at LIKE ?",
      whereArgs: [monthPattern],
    );

    // Convert the result to a list of BillModel objects
    List<BillModel> bills = result.map((e) => BillModel.fromMap(e)).toList();
    return bills;
  }

  Future<List<BillProductModel>> getBillProducts({required int billId}) async {
    final db = await _dbHelper.database;
    final result = await db
        .query('bill_products', where: "bill_id =  ?", whereArgs: [billId]);
    List<BillProductModel> prodcuts =
        result.map((e) => BillProductModel.fromMap(e)).toList();
    return prodcuts;
  }

  Future<List<BillModel>> searchForABill(String text) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'bills',
      where: 'id LIKE ?',
      whereArgs: ['%$text%'], // Use % to allow partial matches
    );
    return result.map((map) => BillModel.fromMap(map)).toList();
  }

  Future<ProductModel> getProductByBarCode({
    required String barcode,
  }) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'products',
      where: 'barcode = ?',
      whereArgs: [
        barcode,
      ],
    );
    ProductModel productModel = ProductModel.fromMap(result[0]);
    return productModel;
  }

  Future<List<BillModel>> getRecentBills() async {
    final db = await _dbHelper.database;

    // Query to fetch the most recent 5 bills, ordered by creation date in descending order
    final result = await db.query(
      'bills',
      orderBy: 'created_at DESC', // Sort by creation date in descending order
      limit: 5, // Limit the results to 5 bills
    );

    // Convert the result to a list of BillModel objects
    List<BillModel> bills = result.map((e) => BillModel.fromMap(e)).toList();
    return bills;
  }

  /// Function to delete a bill by its ID
  Future<void> deleteBillAndItsBillProduct({required int billId}) async {
    final db = await _dbHelper.database;
    // deleting the bill
    await db.delete(
      'bills',
      where: 'id = ?',
      whereArgs: [billId],
    );

//fethcing the bill products related to the bill  and mapping them into an array of productsBillModels
    final result = await db
        .query('bill_products', where: "bill_id =  ?", whereArgs: [billId]);
    List<BillProductModel> products =
        result.map((e) => BillProductModel.fromMap(e)).toList();

//looping throught each billProductModel
    for (var i = 0; i < products.length; i++) {
      BillProductModel billProductModel = products[i];
      //fetching the product related to the bill MOdel
      final result = await db.query(
        'products',
        where: 'id = ?',
        whereArgs: [billProductModel.productId],
        limit: 1,
      );
      ProductModel product = ProductModel.fromMap(result.first);

      //Insert the new quantitiy
      product = product.copyWith(
          soldQuantity: product.soldQuantity - billProductModel.quantity,
          wareHouseQuantity:
              product.wareHouseQuantity + billProductModel.quantity);
      await db.update(
        'products',
        product.toMap(),
        where: 'id = ?',
        whereArgs: [product.id],
      );
      WarehouseDataSource().updateWarehouse(
          wareHouseId: product.warehouseId,
          additionalQuantity: billProductModel.quantity);
    }
  }
}
