import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Initialize sqflite_ffi
    sqfliteFfiInit();

    // Get the database path
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'warehouse.db');

    return await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
      ),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE,
        password TEXT,
        role TEXT
      )
    ''');
    // Create the warehouses table
    await db.execute('''
  CREATE TABLE warehouses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL , 
 product_count INTEGER
  )
''');

    await db.execute('''
  CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    warehouse_id INTEGER, -- Corrected column name
    FOREIGN KEY (warehouse_id) REFERENCES warehouses (id) ON DELETE CASCADE
  )
''');

    await db.execute('''
  CREATE TABLE products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    barcode TEXT, -- Barcode column
    traderPrice REAL, -- Trader price column (REAL for decimal values)
    customerPrice REAL, -- Customer price column (REAL for decimal values)
    quantity INTEGER, -- Quantity column
    sold_quantity INTEGER, 
    warehouse_id INTEGER, -- Foreign key to warehouses table
    category_id INTEGER,  -- Foreign key to categories table
    bill_quantity INTEGER DEFAULT 1, -- New column with default value 1
    color TEXT, -- New column for color (string type)
    critical_quantity INTEGER, -- New column for critical quantity (integer type)
    category_name TEXT, -- New column for category name
    warehouse_name TEXT, -- New column for warehouse name
       size TEXT, -- New column for size (string type)
    FOREIGN KEY (warehouse_id) REFERENCES warehouses (id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
  )
''');

    await db.execute('''
  CREATE TABLE bills (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at TEXT NOT NULL DEFAULT (datetime('now')), -- Use TEXT for SQLite datetime
    customer_name TEXT,
    phone_number TEXT,
    total REAL -- Use REAL for double precision
  )
''');
    await db.execute('''
  CREATE TABLE billing (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at TEXT NOT NULL DEFAULT (datetime('now')), -- Use TEXT for SQLite datetime
    total REAL -- Use REAL for double precision
  )
''');
    await db.execute('''
  CREATE TABLE expenses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at TEXT NOT NULL DEFAULT (datetime('now')), -- Use TEXT for SQLite datetime
    price REAL, -- Use REAL for double precision
    name TEXT NOT NULL -- Name column
  )
''');

    await db.execute('''
  CREATE TABLE bill_products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at TEXT NOT NULL DEFAULT (datetime('now')), -- Use TEXT for SQLite datetime
    bill_id INTEGER, -- Foreign key to bills table
    product_id INTEGER, -- Foreign key to products table
    name TEXT,
    total REAL, -- Changed from price to total
    quantity INTEGER, -- Use INTEGER for smallint
    barcode TEXT,
    FOREIGN KEY (bill_id) REFERENCES bills (id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE -- Added foreign key
  )
''');
  }

  // Helper function to get the database path
  Future<String> getDatabasesPath() async {
    return join(await databaseFactory.getDatabasesPath(), 'warehouse.db');
  }
}
