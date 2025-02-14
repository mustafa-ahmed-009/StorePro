
import 'package:shops_manager_offline/core/config/data_base_helper.dart';
import 'package:shops_manager_offline/features/warehouses/data/models/warehouses_model.dart';

class WarehouseDataSource {
  final DatabaseHelper _dbHelper =
      DatabaseHelper(); // creating a singlton isntance for my helper

  Future<List<WarehouseModel>> getWarehouses() async {
    final db = await _dbHelper.database;
    final result = await db.query('warehouses');
    return result.map((map) => WarehouseModel.fromMap(map)).toList();
  }

  Future<int> addWarehouse(WarehouseModel warehouse) async {
    final db = await _dbHelper.database;
    return await db.insert('warehouses', warehouse.toMap());
  }

  Future<int> updateWarehouse({ required int wareHouseId , required int additionalQuantity ,}) async {
    final db = await _dbHelper.database;
 final currentWarehouse = await db.query(
    'warehouses',
    where: 'id = ?',
    whereArgs: [wareHouseId],
  );
   if (currentWarehouse.isNotEmpty) {
    final currentQuantity = currentWarehouse.first['product_count'] as int;

    // Update the warehouse with the new quantity
    return await db.update(
      'warehouses',
      {
        'product_count': currentQuantity + additionalQuantity,
      },
      where: 'id = ?',
      whereArgs: [wareHouseId],
    );
  } else {
    throw Exception('Warehouse not found');
  }

  }

  Future<int> deleteWarehouse(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'warehouses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

    Future<String> getWarehosueById(int id) async{
        final db = await _dbHelper.database;
    final result = await db.query('warehouses',
      where: 'id = ?',
      whereArgs: [id],
    );
   final warehouseName =  result[0]["name"] as String;
   return warehouseName; 
}
}

// Import sqflite_common_ffi

// Import the Platform class
