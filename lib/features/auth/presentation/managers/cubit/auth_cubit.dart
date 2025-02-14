// lib/presentation/cubits/auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/features/auth/data/models/user_model.dart';
import 'package:shops_manager_offline/features/auth/data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepository _userRepository;

  AuthCubit(this._userRepository) : super(AuthInitial());

  // Register a new user
  Future<void> registerUser(String email, String password, String role) async {
    emit(AuthLoading());
    final result = await _userRepository.registerUser(
      UserModel(email: email, password: password, role: role),
    );
    result.fold(
      (failure) => emit(AuthError(failure.errMessage)), // Handle failure
      (userId) => emit(AuthSuccess('تم التسجيل بنجاح')), // Handle success
    );
  }

  // Authenticate a user
  Future<void> loginUser(String email, String password) async {
    emit(AuthLoading());
    final result = await _userRepository.authenticateUser(email, password);
    result.fold(
      (failure) => emit(AuthError(failure.errMessage)), // Handle failure
      (user) => emit(AuthLoggedIn(user)), // Handle success
    );
  }
    Future<void> changePassword({
    required int userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(AuthLoading());
    try {
      final result = await _userRepository.changeUserPassword(
          newPassword: newPassword, oldPassword: oldPassword, userId: userId);
      result.fold(
        (failure) => emit(AuthError(failure.errMessage)),
        (users) => emit(AuthPasswordChangingSuccess()),
      );
    } catch (e) {
      emit(AuthError( 'Failed to update product: $e'));
    }
  }
}