import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/food_item.dart';

import '../repositories/food_repository.dart';

class FoodLocalDataSource implements FoodStorage {
  static const _dbName = 'food_log.db';
  static const _table = 'meals';

  Database? _db;

  Future<Database> get _database async {
    if (_db != null) return _db!;
    final dbPath = await getDatabasesPath();
    _db = await openDatabase(
      join(dbPath, _dbName),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_table(
            id TEXT PRIMARY KEY,
            name TEXT,
            calories REAL,
            protein REAL,
            carbs REAL,
            fat REAL,
            quantity REAL,
            imageUrl TEXT,
            timestamp INTEGER
          )
        ''');
      },
    );
    return _db!;
  }

  Future<List<FoodItem>> getDailyMeals(DateTime date) async {
    final db = await _database;
    final start = DateTime(
      date.year,
      date.month,
      date.day,
    ).millisecondsSinceEpoch;
    final end = start + const Duration(days: 1).inMilliseconds;

    final maps = await db.query(
      _table,
      where: 'timestamp >= ? AND timestamp < ?',
      whereArgs: [start, end],
      orderBy: 'timestamp DESC',
    );

    return maps
        .map(
          (e) => FoodItem.fromJson({
            ...e,
            'timestamp': DateTime.fromMillisecondsSinceEpoch(
              e['timestamp'] as int,
            ).toIso8601String(),
          }),
        )
        .toList();
  }

  Future<void> insertMeal(FoodItem item) async {
    final db = await _database;
    await db.insert(_table, {
      ...item.toJson(),
      'timestamp': item.timestamp.millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteMeal(FoodItem item) async {
    final db = await _database;
    await db.delete(_table, where: 'id = ?', whereArgs: [item.id]);
  }

  Future<void> updateMeal(FoodItem item) async {
    final db = await _database;
    await db.update(
      _table,
      {...item.toJson(), 'timestamp': item.timestamp.millisecondsSinceEpoch},
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }
}
