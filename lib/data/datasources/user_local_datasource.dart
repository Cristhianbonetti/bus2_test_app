import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<List<UserModel>> getAllSavedUsers();
  Future<void> deleteUser(String uuid);
  Future<bool> isUserSaved(String uuid);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  static const String _tableName = 'users';
  static const String _databaseName = 'users_database.db';
  static const int _databaseVersion = 1;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        uuid TEXT PRIMARY KEY,
        userData TEXT NOT NULL,
        createdAt INTEGER NOT NULL
      )
    ''');
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final db = await database;
    final userData = json.encode(user.toJson());

    await db.insert(
      _tableName,
      {
        'uuid': user.login.uuid,
        'userData': userData,
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<UserModel>> getAllSavedUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      orderBy: 'createdAt DESC',
    );

    return List.generate(maps.length, (i) {
      final userData = json.decode(maps[i]['userData'] as String);
      return UserModel.fromJson(userData as Map<String, dynamic>);
    });
  }

  @override
  Future<void> deleteUser(String uuid) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
  }

  @override
  Future<bool> isUserSaved(String uuid) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
    return maps.isNotEmpty;
  }
}

