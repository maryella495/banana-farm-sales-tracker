import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:myapp/models/sale.dart';
import 'package:logger/logger.dart';

/// DatabaseService
/// ----------------
/// Handles local SQLite persistence for sales.
/// Provides CRUD operations: insert, fetch, update, delete.
///
/// Notes:
/// - Uses Sale.toMap() and Sale.fromMap() for conversion.
/// - Table schema matches Sale model fields.
/// - Call DatabaseService.instance.init() before using.

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _db;
  static final Logger _logger = Logger();

  /// Singleton accessor
  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  /// Initialize database
  Future<void> init() async {
    if (_db != null) return;

    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'sales.db');

      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE sales (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              buyer TEXT,
              variety TEXT,
              quantity INTEGER,
              price REAL,
              date TEXT,
              notes TEXT
            )
          ''');
        },
      );
      _logger.i("Database initialized at $path");
    } catch (e) {
      _logger.e("Error initializing database", error: e);
    }
  }

  /// Helper to ensure DB is ready
  Future<Database> get database async {
    if (_db == null) {
      _logger.w("Database not initialized yet, calling init()");
      await init();
    }
    return _db!;
  }

  /// Insert a new sale
  /// Returns the inserted row ID
  Future<int> insertSale(Sale sale) async {
    try {
      final db = await database; // ✅ always get initialized DB
      final map = sale.toMap();
      debugPrint("_db is null? ${_db == null}"); // 👀 check before insert
      debugPrint("insertSale map: $map");
      final id = await db.insert('sales', map);
      debugPrint("Inserted sale with id $id");
      return id;
    } catch (e, st) {
      debugPrint("DB insert error: $e\n$st");
      return -1;
    }
  }

  /// Fetch all sales
  Future<List<Sale>> getSales() async {
    try {
      final db = await database;
      final maps = await db.query('sales');
      _logger.i("Fetched ${maps.length} sales from database");
      return maps.map((map) => Sale.fromMap(map)).toList();
    } catch (e) {
      _logger.e("Error fetching sales", error: e);
      return [];
    }
  }

  /// Update a sale
  Future<int> updateSale(Sale sale) async {
    try {
      final db = await database;
      final rows = await db.update(
        'sales',
        sale.toMap(),
        where: 'id = ?',
        whereArgs: [sale.id],
      );
      _logger.i("Updated sale with id ${sale.id}, rows affected: $rows");
      return rows;
    } catch (e) {
      _logger.e("Error updating sale", error: e);
      return 0;
    }
  }

  /// Delete a sale by id
  Future<int> deleteSale(int id) async {
    try {
      final db = await database;
      final rows = await db.delete('sales', where: 'id = ?', whereArgs: [id]);
      _logger.i("Deleted sale with id $id, rows affected: $rows");
      return rows;
    } catch (e) {
      _logger.e("Error deleting sale", error: e);
      return 0;
    }
  }

  /// Delete all sales
  Future<int> clearSales() async {
    try {
      final db = await database;
      final rows = await db.delete('sales');
      _logger.w("Cleared all sales, rows affected: $rows");
      return rows;
    } catch (e) {
      _logger.e("Error clearing sales", error: e);
      return 0;
    }
  }
}
