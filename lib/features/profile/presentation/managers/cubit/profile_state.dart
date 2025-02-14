part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}
final class ProfileDeleting extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final UserModel userModel;

  ProfileSuccess({required this.userModel});
}

final class FetchingAllUsersSuccess extends ProfileState {
  final List<UserModel> users;

  FetchingAllUsersSuccess({required this.users});
}

final class ProfileFailure extends ProfileState {
  final String errorMessage;

  ProfileFailure({required this.errorMessage});
}
