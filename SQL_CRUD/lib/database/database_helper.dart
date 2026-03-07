import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user_model.dart';

class DatabaseHelper {
  DatabaseHelper._internal();

  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'users.db');

    final db = await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL,
            password TEXT NOT NULL,
            gender TEXT NOT NULL,
            image TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            "ALTER TABLE users ADD COLUMN gender TEXT NOT NULL DEFAULT 'Male'",
          );
        }
        if (oldVersion < 3) {
          await _migrateUsersTableToV3(db);
        }
      },
    );

    await _ensureLatestUsersSchema(db);
    return db;
  }

  Future<void> _ensureLatestUsersSchema(Database db) async {
    final columns = await db.rawQuery('PRAGMA table_info(users)');
    final hasGender = columns.any((column) => column['name'] == 'gender');
    final hasAge = columns.any((column) => column['name'] == 'age');

    if (!hasGender) {
      await db.execute(
        "ALTER TABLE users ADD COLUMN gender TEXT NOT NULL DEFAULT 'Male'",
      );
    }

    if (hasAge) {
      await _migrateUsersTableToV3(db);
    }
  }

  Future<void> _migrateUsersTableToV3(Database db) async {
    await db.transaction((txn) async {
      await txn.execute('''
        CREATE TABLE users_new (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT NOT NULL,
          password TEXT NOT NULL,
          gender TEXT NOT NULL,
          image TEXT
        )
      ''');

      await txn.execute('''
        INSERT INTO users_new (id, name, email, password, gender, image)
        SELECT id, name, email, password, COALESCE(gender, 'Male'), image
        FROM users
      ''');

      await txn.execute('DROP TABLE users');
      await txn.execute('ALTER TABLE users_new RENAME TO users');
    });
  }

  Future<int> insertUser(UserModel user) async {
    final db = await database;
    return db.insert('users', user.toMap());
  }

  Future<List<UserModel>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      orderBy: 'id DESC',
    );

    return maps.map(UserModel.fromMap).toList();
  }

  Future<int> updateUser(UserModel user) async {
    final db = await database;
    return db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
