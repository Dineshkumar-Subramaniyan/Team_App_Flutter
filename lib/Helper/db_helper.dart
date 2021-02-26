import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static final DataBaseHelper _instance = new DataBaseHelper.internal();
  factory DataBaseHelper() => _instance;
  static Database _db;
  final String dbName = "TeamAppDB";
  final String team = "team";
  final String employee = "employee";
  final String teammember = "tmember";
  DataBaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDataBase();
    return _db;
  }

  initDataBase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "$dbName.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    //Create table team
    await db
        .execute("CREATE TABLE $team (teamid integer primary key,tname text)");
//Create table employee
    await db.execute(
        "CREATE TABLE $employee (empid integer primary key,ename text,age integer,city text,istl bit default 0,tlname text,tlid integer)");
    //Create table team member
    await db.execute(
        "CREATE TABLE $teammember (tmemid integer primary key,teamid text,tname text,empid int)");
  }

  Future<List<Map<String, dynamic>>> getDataFromDB(String tablename) async {
    var db = DataBaseHelper._db;
    return db.query(tablename);
  }
}
