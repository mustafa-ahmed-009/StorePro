import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/core/constants.dart';
import 'package:shops_manager_offline/core/functions/extensions.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/auth/data/repo/auth_repo.dart';
import 'package:shops_manager_offline/features/auth/presentation/managers/cubit/auth_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedRole;
  bool _obscurePassword = true; // Toggle for password visibility
  bool _obscureConfirmPassword = true; // Toggle for confirm password visibility
  String? mappedRole;

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
              'تسجيل جديد',
              style: AppStyles.styleSemiBold20(context),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                // Handle success and error states
                if (state is AuthSuccess) {
               context.showSuccessSnackBar(message: 'تم تسجيل الحساب بنجاح');
                  Navigator.pop(
                      context); // Navigate back after successful registration
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
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          style: AppStyles.styleRegular16(context),
                          obscureText: _obscurePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال كلمة المرور';
                            }
                            if (value.length < 6) {
                              return 'يجب أن تكون كلمة المرور على الأقل 6 أحرف';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: 'تأكيد كلمة المرور',
                            labelStyle: AppStyles.styleRegular16(context),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ),
                          style: AppStyles.styleRegular16(context),
                          obscureText: _obscureConfirmPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء تأكيد كلمة المرور';
                            }
                            if (value != _passwordController.text) {
                              return 'كلمة المرور غير متطابقة';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedRole,
                          decoration: InputDecoration(
                            labelText: 'الدور',
                            labelStyle: AppStyles.styleRegular16(context),
                          ),
                          style: AppStyles.styleRegular16(context),
                          items: ['مدير', 'مستخدم عادي']
                              .map((role) => DropdownMenuItem(
                                    value: role,
                                    child: Text(role),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedRole =
                                  value!; // Update the selected role
                              // Map the selected value to "admin" or "user" if needed
                              mappedRole = value == "مدير" ? "admin" : "user";
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء اختيار دور';
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
                              final role = mappedRole;

                              // Call the registerUser method from AuthCubit
                              context.read<AuthCubit>().registerUser(
                                    email,
                                    password,
                                    role ?? 'مستخدم عادي', // Default role
                                  );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            textStyle: AppStyles.styleSemiBold18(context),
                          ),
                          child: Text('تسجيل'),
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
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
