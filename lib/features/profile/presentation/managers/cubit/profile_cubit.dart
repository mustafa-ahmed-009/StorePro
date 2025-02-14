import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shops_manager_offline/core/functions/shared_preferences.dart';
import 'package:shops_manager_offline/features/auth/data/models/user_model.dart';
import 'package:shops_manager_offline/features/profile/data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _productsRepo = ProfileRepo();
  ProfileCubit() : super(ProfileInitial());
  // Update an existing product
  Future<void> fetchUserData() async {
    emit(ProfileLoading());
    final int userId = await getUserId();
    try {
      final result = await _productsRepo.fetchUserData(userId: userId);
      result.fold(
        (failure) => emit(ProfileFailure(errorMessage: failure.errMessage)),
        (user) => emit(ProfileSuccess(userModel: user)),
      );
    } catch (e) {
      emit(ProfileFailure(errorMessage: 'Failed to update product: $e'));
    }
  }
    Future<void> deleteUser({required int userId }) async {
    emit(ProfileLoading());
    try {
      final result = await _productsRepo.deleteUser(userId: userId);
      result.fold(
        (failure) => emit(ProfileFailure(errorMessage: failure.errMessage)),
        (_) => fetchAllUsers(),
      );
    } catch (e) {
      emit(ProfileFailure(errorMessage: 'Failed to update product: $e'));
    }
  }

  Future<void> fetchAllUsers() async {
    emit(ProfileLoading());
    try {
      final result = await _productsRepo.fetchAllUsers();
      result.fold(
        (failure) => emit(ProfileFailure(errorMessage: failure.errMessage)),
        (users) => emit(FetchingAllUsersSuccess(users: users)),
      );
    } catch (e) {
      emit(ProfileFailure(errorMessage: 'Failed to update product: $e'));
    }
  }


}
