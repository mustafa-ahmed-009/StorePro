import 'package:shops_manager_offline/core/config/data_base_helper.dart';
import 'package:shops_manager_offline/features/auth/data/models/user_model.dart';

class ProfileDataSource {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Future<UserModel> fetchUserData(int userId) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );
      return UserModel.fromMap(result.first);
  }
    Future<List<UserModel>> fetchAllUsers() async {
    final db = await _dbHelper.database;
    final result = await db.query('users');
    return result.map((map) => UserModel.fromMap(map)).toList();
  }


Future<void> deleteUser(int userId) async {
  final db = await _dbHelper.database;

  // Check if the user exists
  final user = await fetchUserData(userId);

  // Delete the user
  await db.delete(
    'users',
    where: 'id = ?',
    whereArgs: [userId],
  );
}


  Future<bool> isUserAdmin(String userID) async {
  final db = await DatabaseHelper().database;
  final maps = await db.query(
    'users',
    where: 'id = ?',
    whereArgs: [userID],
  );

  // Check if the user exists
  if (maps.isNotEmpty) {
    final user = UserModel.fromMap(maps.first); // Convert the result to UserModel
    return user.role.toLowerCase() == 'admin'; // Check if the user is an admin
  }

  // If the user is not found, return false
  return false;
}
}

