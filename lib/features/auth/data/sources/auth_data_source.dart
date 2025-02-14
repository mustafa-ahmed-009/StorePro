import 'package:shops_manager_offline/core/config/data_base_helper.dart';
import 'package:shops_manager_offline/core/config/password_hasher.dart';
import 'package:shops_manager_offline/features/auth/data/models/user_model.dart';

class AuthDataSource {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Future<void> updatePassword({
    required int userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    final db = await _dbHelper.database;

    // Step 1: Fetch the user's current password from the database
    final result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (result.isEmpty) {
      throw Exception('المستخدم غير موجود');
    }

    final user = UserModel.fromMap(result.first);

    // Step 2: Verify the old password
    final isOldPasswordCorrect = PasswordHasher.verifyPassword(
      oldPassword,
      user.password, // The hashed password stored in the database
    );

    if (!isOldPasswordCorrect) {
      throw Exception('كلمة المرور القديمة غير صحيحة');
    }

    // Step 3: Hash the new password
    final hashedNewPassword = PasswordHasher.hashPassword(newPassword);

    // Step 4: Update the password in the database
    await db.update(
      'users',
      {'password': hashedNewPassword},
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<int> insertUser(UserModel user) async {
    final db = await _dbHelper.database;
    return await db.insert('users', user.toMap());
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  Future<UserModel?> authenticateUser(String email, String password) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      final user = UserModel.fromMap(result[0]);
      // Verify the password against the hashed password
      if (PasswordHasher.verifyPassword(password, user.password)) {
        return user;
      }
    }
    return null;
  }
}
