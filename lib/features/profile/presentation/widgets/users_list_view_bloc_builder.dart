import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/auth/data/models/user_model.dart';
import 'package:shops_manager_offline/features/profile/presentation/managers/cubit/profile_cubit.dart';

class UsersListViewBlocBuilder extends StatelessWidget {
  const UsersListViewBlocBuilder({
    super.key,
    required this.profileCubit,
  });
  final ProfileCubit profileCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..fetchAllUsers(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is FetchingAllUsersSuccess) {
            return ListView.builder(
              shrinkWrap:
                  true, // Allows ListView to size itself based on children
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
            
                return ListTile(
                  title: Text(
                    user.email,
                    style: AppStyles.styleSemiBold16(context),
                  ),
                  subtitle: Text(
                    'الدور: ${user.role}',
                    style: AppStyles.styleRegular14(context).copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteUser(
                              context, user, context.read<ProfileCubit>());
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is ProfileFailure) {
            return Center(
              child: Text(
                'فشل في تحميل المستخدمين',
                style: AppStyles.styleSemiBold16(context).copyWith(
                  color: Colors.red,
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  // Function to handle changing password
  void _changePassword(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'تغيير كلمة المرور',
            style: AppStyles.styleSemiBold18(context),
          ),
          content: Text(
            'هل أنت متأكد أنك تريد تغيير كلمة المرور لهذا المستخدم؟',
            style: AppStyles.styleRegular16(context),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'إلغاء',
                style: AppStyles.styleMedium16(context),
              ),
            ),
            TextButton(
              onPressed: () {
                // Call the Cubit method to change the password
                //    context.read<ProfileCubit>().changePassword(user.id);
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'تأكيد',
                style: AppStyles.styleMedium16(context),
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to handle changing role
  void _changeRole(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'تغيير الدور',
            style: AppStyles.styleSemiBold18(context),
          ),
          content: Text(
            'هل أنت متأكد أنك تريد تغيير دور هذا المستخدم؟',
            style: AppStyles.styleRegular16(context),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'إلغاء',
                style: AppStyles.styleMedium16(context),
              ),
            ),
            TextButton(
              onPressed: () {
                // Call the Cubit method to change the role
                //     context.read<ProfileCubit>().changeRole(user.id, 'new_role'); // Replace 'new_role' with the desired role
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'تأكيد',
                style: AppStyles.styleMedium16(context),
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to handle deleting a user
  void _deleteUser(
      BuildContext context, UserModel user, ProfileCubit profileCubit) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'حذف المستخدم',
            style: AppStyles.styleSemiBold18(context),
          ),
          content: Text(
            'هل أنت متأكد أنك تريد حذف هذا المستخدم؟',
            style: AppStyles.styleRegular16(context),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'إلغاء',
                style: AppStyles.styleMedium16(context).copyWith(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Call the Cubit method to delete the user
                profileCubit.deleteUser(userId: user.id!);
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'حذف',
                style: AppStyles.styleMedium16(context).copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
