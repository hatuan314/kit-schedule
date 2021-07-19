import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database? db;

class DatabaseCreator {
  static const scheduleTable = 'SCHEDULE';
  static const lessonTable = 'LESSON';
  static const personaScheduleTable = 'PERSONAL';

  static void databaseLog(String functionName, String sql,
      [List<Map<String, dynamic>>? selectQueryResult,
      int? insertAndUpdateQueryResult,
      List<dynamic>? params]) {
    print(functionName);
    print(sql);
    if (params != null) {
      print(params);
    }
    if (selectQueryResult != null) {
      print(selectQueryResult);
    } else if (insertAndUpdateQueryResult != null) {
      print(insertAndUpdateQueryResult);
    }
  }

  /// CREATE SCHEDULE TABLE
  Future<void> createScheduleTable(Database db) async {
    final appNotiSql = '''CREATE TABLE $scheduleTable
    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT
    )''';

    await db.execute(appNotiSql);
  }

  /// CREATE LESSON TABLE
  Future<void> createLessonTable(Database db) async {
    final appNotiSql = '''CREATE TABLE $lessonTable
    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT,
      lesson TEXT,
      subject_name TEXT,
      address TEXT
    )''';

    await db.execute(appNotiSql);
  }

  /// FUTURE PERSONAL SCHEDULE TABLE
  Future<void> createPersonalScheduleTable(Database db) async {
    final appNotiSql = '''CREATE TABLE $personaScheduleTable
    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT,
      timer TEXT,
      schedule_name TEXT,
      note TEXT
    )''';

    await db.execute(appNotiSql);
  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    //make sure the folder exists
    if (await Directory(dirname(path)).exists()) {
      //await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath('kit_schedule_db');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }

  Future<void> onCreate(Database db, int version) async {
    await createScheduleTable(db);
    await createLessonTable(db);
    await createPersonalScheduleTable(db);
  }
}
