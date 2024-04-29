import 'dart:async';
import 'dart:io';
import 'package:homeappliances/ServiceProvider.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

import 'RegisterUser.dart';

class DatabaseHelper{
static final _databaseName="tashfil";
static final table="logintable";
static final serviceProvidertable="sericeProvider";
static final _databaseVersion = 1;
static final columnId = 'id';
static final columnName = 'username';
static final Name = 'name';
static final columnPassword = 'password';
static final columnemail = 'Email';
static final columncontact = 'Contact';
static final serviceId = 'id';
static final serviceName = 'servicename';
static final serviceprovided='serviceprovided';
static final servicearea='servicearea';

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
        $Name TEXT NOT NULL,
        $columnPassword TEXT NOT NULL,
        $columnemail TEXT NOT NULL,
        $columncontact TEXT NOT NULL
      )
    ''');


  await db.execute('''
      CREATE TABLE  IF NOT EXISTS $serviceProvidertable (
       $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columncontact TEXT NOT NULL,
        $serviceName TEXT NOT NULL,
        $serviceprovided TEXT NOT NULL,
        $servicearea TEXT NOT NULL
      )
    ''');

}

Future<int> insertUser(Map<String, dynamic> row) async {
  Database? db = await instance.database;
  return await db?.insert(table, row)??0;
}


Future<int> insertserviceprovider(Map<String, dynamic> row) async {
  Database? db = await instance.database;
  return await db?.insert(serviceProvidertable, row)??0;
}


Future<Map<String, dynamic>?> getUser(String useremail) async {
  Database? db = await instance.database;
  List<Map<String, dynamic>> result = await db?.query(table,
      where: '$columnemail = ?', whereArgs: [useremail])??[];
  return result.isNotEmpty ? result.first : null;
}

Future<Map<String, dynamic>?> deleteUser(String id) async {
  Database? db = await instance.database;
  await db?.delete(table,
      where: '$columncontact = ?', whereArgs: [id])??[];

}



Future<void> updateLoginRecord(String username,String email, String contact) async {
  Database? db = await instance.database;
  await db?.update(
      table,
      {columnName: username, columncontact: contact, columnemail: email},
      where: '$columncontact = ?',
      whereArgs: [contact]
  );
}

Future<List<UserData>> getallUser() async {
  final Database? db = await database;
  final List<Map<String, dynamic>>? maps = await db?.query('logintable');
  return List.generate(maps!.length, (i) {
    return  UserData(
      name: maps[i]['username'] ?? '',
      contact: maps[i]['Contact'] ?? '',
      email: maps[i]['Email'] ?? '',
    );
  });
}


}