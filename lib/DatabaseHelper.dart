import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
static final _databaseName="tashfil";
static final table="logintable";
static final _databaseVersion = 1;
static final columnId = 'id';
static final columnName = 'username';
static final Name = 'name';
static final columnPassword = 'password';
static final columnemail = 'Email';
static final columncontact = 'Contact';

DatabaseHelper._privateConstructor();
static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

static Database? _database=null;

Future<Database?> get database async {
  if (_database != null) return _database;

  _database = await _initDatabase();
  return _database;
}

_initDatabase() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, _databaseName);
  return await openDatabase(path,
      version: _databaseVersion, onCreate: _onCreate);
}

Future _onCreate(Database db, int version) async {
  await db.execute('''
      CREATE TABLE  IF NOT EXISTS $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnPassword TEXT NOT NULL,
        $columnemail TEXT NOT NULL,
        $columncontact TEXT NOT NULL
      )
    ''');







}

Future<int> insertUser(Map<String, dynamic> row) async {
  Database? db = await instance.database;
  return await db?.insert(table, row)??0;
}

Future<Map<String, dynamic>?> getUser(String username) async {
  Database? db = await instance.database;
  List<Map<String, dynamic>> result = await db?.query(table,
      where: '$columnName = ?', whereArgs: [username])??[];
  return result.isNotEmpty ? result.first : null;
}


}