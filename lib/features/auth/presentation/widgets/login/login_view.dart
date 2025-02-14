import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/constants.dart';
import 'package:shops_manager_offline/core/functions/extensions.dart';
import 'package:shops_manager_offline/core/functions/shared_preferences.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/auth/data/repo/auth_repo.dart';
import 'package:shops_manager_offline/features/auth/presentation/managers/cubit/auth_cubit.dart';
import 'package:shops_manager_offline/features/auth/presentation/widgets/register/register_view.dart';
import 'package:shops_manager_offline/features/home/home_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Provide the AuthCubit to the widget tree
      create: (context) => AuthCubit(UserRepository()),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'تسجيل الدخول',
              style: AppStyles.styleSemiBold20(context),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                // Handle success and error states
                if (state is AuthLoggedIn) {
                  context.showSuccessSnackBar(message: 'تم تسجيل الدخول بنجاح');
                  storeUserData(
                      logged: true,
                      id: state.user.id!,
                      isAdmin: state.user.role == 'admin');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreenView()),
                  );
                } else if (state is AuthError) {
                  context.showErrorSnackBar(message: state.message);
                }
              },
              builder: (context, state) {
                // Show a loading indicator while processing
                if (state is AuthLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                // Build the form
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(klogoPath),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'البريد الإلكتروني',
                            labelStyle: AppStyles.styleRegular16(context),
                          ),
                          style: AppStyles.styleRegular16(context),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال البريد الإلكتروني';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'الرجاء إدخال بريد إلكتروني صحيح';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'كلمة المرور',
                            labelStyle: AppStyles.styleRegular16(context),
                          ),
                          style: AppStyles.styleRegular16(context),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال كلمة المرور';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final email = _emailController.text;
                              final password = _passwordController.text;

                              // Call the loginUser method from AuthCubit
                              context
                                  .read<AuthCubit>()
                                  .loginUser(email, password);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            textStyle: AppStyles.styleSemiBold18(context),
                          ),
                          child: Text('تسجيل الدخول'),
                        ),
                        SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()),
                            );
                          },
                          child: Text(
                            'ليس لديك حساب؟ سجل هنا',
                            style: AppStyles.styleRegular16(context).copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
