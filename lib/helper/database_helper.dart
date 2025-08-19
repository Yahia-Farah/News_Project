import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  DatabaseHelper._();
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB('my_database.db');
    return _database!;
  }

   static Future<Database> initDB(String path) async {
    join(await getDatabasesPath(),path);
    return await openDatabase(path,version: 1,onCreate: createDB);
   }


   static Future<void> createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE Saved_News(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    source TEXT,
    author TEXT,
    description TEXT,
    url TEXT,
    urlToImage TEXT,
    publishedAt TEXT,
    title TEXT,
    content TEXT
    )
    ''');
  }
  static void insert(Map<String,dynamic> row)async{
    await _database?.insert('Saved_News', row);
  }

}
