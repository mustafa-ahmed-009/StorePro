import 'package:dartz/dartz.dart';
import 'package:shops_manager_offline/core/config/failures.dart';
import 'package:shops_manager_offline/core/config/sqflite_data_base_failure.dart';
import 'package:shops_manager_offline/features/auth/data/models/user_model.dart';
import 'package:shops_manager_offline/features/profile/data/sources/profile_data_source.dart';

class ProfileRepo {
  final ProfileDataSource _dataSource = ProfileDataSource();

  Future<Either<Failure, UserModel>> fetchUserData({required userId}) async {
    try {
      final result = await _dataSource.fetchUserData(userId);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

  Future<Either<Failure, List<UserModel>>> fetchAllUsers() async {
    try {
      final result = await _dataSource.fetchAllUsers();
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }
  Future<Either<Failure, void>> deleteUser({required int userId}) async {
    try {
      final result = await _dataSource.deleteUser(userId);
      return right(result);
    } catch (e) {
      return left(SqfliteDatabaseFailure.fromDatabaseError(e));
    }
  }

}
