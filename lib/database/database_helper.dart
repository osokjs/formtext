import 'dart:io';
import 'package:formtext/model/group_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "gobal.db";
  static final _databaseVersion = 1;
  static final _tableName = "groupCode";

  static final colId = 'id';
  static final colName = 'name';

  DatabaseHelper._();
  static final DatabaseHelper _db = DatabaseHelper._();
  factory DatabaseHelper() => _db;

  static Database? _database;

  Future<Database> get database async =>
  _database ??= await _initDatabase();

  // {
  //   if (_database == null) {
  //     _database = await _initDatabase();
  //   }
  //   return _database;
  // }

Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _databaseName);
    return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $_tableName (
            $colId INTEGER PRIMARY KEY AUTOINCREMENT,
            $colName text NOT NULL
          )
          ''');
  }

Future<int> insertGroupCode(String name) async {
    final Database db;
    int result = 0;

    try {
      db = await database;
      result = await db.rawInsert(
          'INSERT INTO $_tableName (name) VALUES (?)',
          [name]);
    } catch (e) {
      print(e.toString());
      throw e;
    }
    print('insert: $result');
    return result;
  }

  Future<List<GroupData>> queryAllGroupCode() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT * FROM $_tableName ORDER BY NAME'
    );

    List<GroupData> list = result.isNotEmpty ?
    result.map((val) => GroupData(id: val['id'], name: val['name'])).toList()
        : []
    ;
    return list;
  }

  Future<int> deleteGroupCode(int id) async {
    final db = await database;
    var result = db.rawDelete(
        'DELETE FROM $_tableName WHERE id = ?',
        [id]
    );
    return result;
  }

  Future<void> deleteAllGroupCode() async {
    final db = await database;
    await db.rawDelete(
        'DELETE FROM $_tableName'
    );
  }

  //Update
  Future<int>  updateGroupCode(GroupData data) async {
    final db = await database;
    var result = db.rawUpdate(
        'UPDATE $_tableName SET name = ? WHERE ID = ?',
        [data.name, data.id]
    );
    return result;
  }


} // class DatabaseHelper
