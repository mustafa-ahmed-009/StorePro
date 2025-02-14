import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// Import sqflite for mobile platforms

// Declare databaseFactory as a global variable

void initializeDatabaseFactory() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit(); // Initialize FFI
    databaseFactory = databaseFactoryFfi; // Set the database factory globally
    print('Initialized databaseFactory for desktop');
  } else {
    databaseFactory = databaseFactory; // Use the default databaseFactory for mobile
    print('Initialized databaseFactory for mobile');
  }
}
