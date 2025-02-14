// lib/presentation/cubits/auth_state.dart
part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}
class AuthPasswordChangingSuccess extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  AuthSuccess(this.message);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthLoggedIn extends AuthState {
  final UserModel user;
  AuthLoggedIn(this.user);
}