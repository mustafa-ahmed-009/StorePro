// lib/core/utils/password_hasher.dart
import 'dart:convert';
import 'package:crypto/crypto.dart';

class PasswordHasher {
  // Hash a password using SHA-256
  static String hashPassword(String password) {
    final bytes = utf8.encode(password); // Convert the password to bytes
    final hash = sha256.convert(bytes); // Hash the bytes using SHA-256
    return hash.toString(); // Convert the hash to a string
  }

  // Verify a password against a hashed password
  static bool verifyPassword(String password, String hashedPassword) {
    return hashPassword(password) == hashedPassword;
  }
}
