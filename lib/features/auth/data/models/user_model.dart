// lib/data/models/user_model.dart

import 'package:shops_manager_offline/core/config/password_hasher.dart';

class UserModel {
  final int? id;
  final String email;
  final String password; // Hashed password
  final String role;

  // Constructor for creating a new user (hashes the password)
  UserModel({
    this.id,
    required this.email,
    required String password, // Accept plain text password
    required this.role,
  }) : password = PasswordHasher.hashPassword(password); // Hash the password

  // Constructor for creating a user from the database (does not hash the password)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel._(
      id: map['id'],
      email: map['email'],
      password: map['password'], // Use the already hashed password
      role: map['role'],
    );
  }

  // Private constructor for internal use (does not hash the password)
  UserModel._({
    this.id,
    required this.email,
    required this.password, // Accept already hashed password
    required this.role,
  });

  // Convert UserModel to a Map (for database operations)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password, // Store the hashed password
      'role': role,
    };
  }
}