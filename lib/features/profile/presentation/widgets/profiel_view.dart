import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/auth/data/models/user_model.dart';
import 'package:shops_manager_offline/features/profile/presentation/managers/cubit/profile_cubit.dart';
import 'package:shops_manager_offline/features/profile/presentation/widgets/add_user_button.dart';
import 'package:shops_manager_offline/features/profile/presentation/widgets/changing_password_button.dart';
import 'package:shops_manager_offline/features/profile/presentation/widgets/log_out_button.dart';
import 'package:shops_manager_offline/features/profile/presentation/widgets/users_list_view_bloc_builder.dart';
import 'package:shops_manager_offline/main.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with RouteAware {
  late ProfileCubit _profileCubit;
  late UserModel? user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscribe to RouteObserver
    ModalRoute.of(context)?.settings.name != null
        ? routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute)
        : null;
  }

  @override
  void initState() {
    super.initState();
    _profileCubit = ProfileCubit();
    _profileCubit.fetchUserData();
  }

  @override
  void didPopNext() {
    // Refresh data when returning to the screen
    _refreshScreenData();
  }

  void _refreshScreenData() {
    _profileCubit.fetchAllUsers();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _profileCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'الملف الشخصي',
            style: TextStyle(fontFamily: 'Alexandria', fontSize: 24),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          bloc: _profileCubit,
          builder: (context, state) {
            UserModel? userModel;
            if (state is ProfileSuccess || state is FetchingAllUsersSuccess) {
              if (state is ProfileSuccess) {
                userModel = state.userModel;
              } else if (state is FetchingAllUsersSuccess) {
                userModel = state.users.firstWhere((user) => user.id == 1);
              }
              return _buildProfileContent(context, userModel!, _profileCubit);
            } else if (state is ProfileFailure) {
              return _buildErrorState(context, state.errorMessage);
            } else {
              return _buildLoadingState();
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfileContent(
      BuildContext context, UserModel user, ProfileCubit profileCubit) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(
                Icons.person,
                size: 60,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),

            // User Details
            Text(
              user.email,
              style: AppStyles.styleSemiBold20(context),
            ),
            const SizedBox(height: 10),
            Text(
              'الدور: ${user.role == 'admin' ? 'مدير' : 'مستخدم'}',
              style: AppStyles.styleRegular16(context)
                  .copyWith(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 30),

            // Buttons Row (Responsive Layout)
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  // Tablet/Desktop Layout (Row)
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildButtons(user, profileCubit),
                  );
                } else {
                  // Mobile Layout (Column)
                  return SizedBox(
                    // Ensures Column does not try to take infinite height
                    width: double.infinity, // Optional, keeps width consistent
                    child: Column(
                      mainAxisSize: MainAxisSize
                          .min, // Important! Prevents infinite height
                      children: _buildButtons(user, profileCubit),
                    ),
                  );
                }
              },
            ),

            // Users List (Only for Admin)
            if (user.role == 'admin')
              UsersListViewBlocBuilder(
                profileCubit: profileCubit,
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildButtons(UserModel user, ProfileCubit profileCubit) {
    return [
      if (user.role == "admin") ChangingPasswordButton(user: user),
      if (user.role == "admin") const SizedBox(width: 10, height: 10),
      if (user.role == "admin") AddUserButton(profileCubit: profileCubit),
      const SizedBox(width: 10, height: 10),
      LogoutButton(),
    ];
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 50,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            Text(
              'فشل في تحميل الملف الشخصي: $errorMessage',
              style:
                  AppStyles.styleRegular16(context).copyWith(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<ProfileCubit>().fetchUserData();
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'إعادة المحاولة',
                style: AppStyles.styleMedium16(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
