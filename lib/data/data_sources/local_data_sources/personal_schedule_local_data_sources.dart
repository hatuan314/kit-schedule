
import 'package:flutter/material.dart';
import 'package:schedule/data/data_sources/database.dart';
import 'package:schedule/data/model/personal_schedule_model.dart';


class PersonalScheduleLocalDataSource {
  /// Add Personal Schedule Data
  Future insertPersonalSchedule(PersonalScheduleModel schedule) async {
    final sql = '''INSERT INTO ${DatabaseCreator.personaScheduleTable}
    (title, note,date, times) VALUES (?, ?, ?, ?)''';

    List<dynamic> params = [
      schedule.title,
      schedule.note,
      schedule.date,
      schedule.times,
    ];
    try {
      final result = await db.rawInsert(sql, params);
      DatabaseCreator.databaseLog(
          'Add Personal Schedule', sql, null, result, params);
    } catch (e) {
      debugPrint('Personal Local Data source - addScheduleLessonProvider - error {$e}');
    }
  }
  /// Select All Personal Schedules+
  Future<List<PersonalScheduleModel>> selectAllPersonalSchedule() async {
    final dateSql =
    '''SELECT * FROM ${DatabaseCreator.personaScheduleTable} ORDER BY date ASC''';
    final scheduleData = await db.rawQuery(dateSql);
    List<PersonalScheduleModel> allSchedules = new List<PersonalScheduleModel>();
    for (final node in scheduleData) {
      PersonalScheduleModel schedule = PersonalScheduleModel.fromJson(node);
      allSchedules.add(schedule);
    }
//    debugPrint('RepositoryService - allSchedulesMap: ${allSchedulesMap.length}');
    return allSchedules;
  }

  /// Select All Personal Schedules Of Date
  Future<List<PersonalScheduleModel>> selectAllPersonalScheduleOfDate(
      String date) async {
    final sql =
    '''SELECT * FROM ${DatabaseCreator.personaScheduleTable} WHERE date = ?''';
    List<dynamic> params = [date];
    final scheduleData = await db.rawQuery(sql, params);
    List<PersonalScheduleModel> schedules = [];
    int i = 0;
    for (final node in scheduleData) {
      print('debug point i =  $i');
      print('node data : $node');
      PersonalScheduleModel schedule = PersonalScheduleModel.fromJson(node);
      i++;
      schedules.add(schedule);
    }
    return schedules;
  }

  /// Update A Personal Schedule Data
  Future<int> updatePersonalScheduleData(
      PersonalScheduleModel schedule) async {
//    debugPrint('ProviderOffline - updatePersonalScheduleData - scheduleId: {${schedule.id}}');
    final data = await db.update(
        DatabaseCreator.personaScheduleTable, schedule.toJson(),
        where: 'id = ?', whereArgs: [schedule.id]);
    return data;
  }

  /// Delete Personal Schedule Data
  Future<int> deletePersonalSchedule(String id) async {
    final data = await db.delete(DatabaseCreator.personaScheduleTable,
        where: 'id = ?', whereArgs: [id]);
    return data;
  }
}