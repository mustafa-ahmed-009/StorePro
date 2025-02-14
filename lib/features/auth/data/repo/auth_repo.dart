// lib/data/repositories/user_repository.dart
import 'package:dartz/dartz.dart';
import 'package:shops_manager_offline/core/config/auth_faiulure.dart';
import 'package:shops_manager_offline/core/config/failures.dart';
import 'package:shops_manager_offline/core/config/sqflite_data_base_failure.dart';
import 'package:shops_manager_offline/features/auth/data/sources/auth_data_source.dart';
import '../models/user_model.dart';

class UserRepository {
  final AuthDataSource _localDataSource = AuthDataSource();

  // Register a new user

  
  Future<Either<Failure, int>> registerUser(UserModel user) async {
    try {
      // Check if the user already exists
      final userExists = await _localDataSource.getUserByEmail(user.email);
      if (userExists != null) {
        return Left(AuthFailure('البريد الإلكتروني مستخدم بالفعل'));
      }

      // Save the user to the database
      final userId = await _localDataSource.insertUser(user);
      return Right(userId);
    } catch (e) {
      return Left(SqfliteDatabaseFailure('حدث خطأ أثناء التسجيل'));
    }
  }

  // Authenticate a user
  Future<Either<Failure, UserModel>> authenticateUser(String email, String password) async {
    try {
      final user = await _localDataSource.authenticateUser(email, password);
      if (user != null) {
        return Right(user);
      } else {
        return Left(AuthFailure('البريد الإلكتروني أو كلمة المرور غير صحيحة'));
      }
    } catch (e) {
      return Left(SqfliteDatabaseFailure('حدث خطأ أثناء تسجيل الدخول'));
    }
  }

  Future<Either<Failure, bool>> userExists(String email) async {
    try {
      final user = await _localDataSource.getUserByEmail(email);
      return Right(user != null);
    } catch (e) {
      return Left(SqfliteDatabaseFailure('حدث خطأ أثناء التحقق من البريد الإلكتروني'));
    }
  }
      Future<Either<Failure, void>> changeUserPassword({    required int userId,
  required String oldPassword,
  required String newPassword,}) async {
    try {
      final result = await _localDataSource.updatePassword(newPassword: newPassword, oldPassword: oldPassword, userId: userId);  
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }
}