// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:schedule/domain/entities/school_schedule_entities.dart';
// import 'package:schedule/models/personal_schedule.dart';
//
// import 'package:schedule/service/services.dart';
//
// class ProviderOffline {
//   /// Add School Schedule Data
//   Future insertSchoolScheduleProvider(SchoolSchedule schedule) async {
//     final sql = '''INSERT INTO ${DatabaseCreator.lessonTable}
//     (date, lesson, subject_name, address) VALUES (?, ?, ?, ?)''';
//     List<dynamic> params = [
//       schedule.date,
//       schedule.lesson,
//       schedule.subject,
//       schedule.address
//     ];
//     try {
//       await db!.rawInsert(sql, params);
// //      debugPrint('ProviderOffline - addScheduleLessonProvider - result: {$result}');
//     } catch (e) {
//       debugPrint('ProviderOffline - addScheduleLessonProvider - error {$e}');
//     }
//   }
//
//   /// Add Personal Schedule Data
//   Future<void> insertPersonalScheduleProvider(PersonalSchedule schedule) async {
//     final sql = '''INSERT INTO ${DatabaseCreator.personaScheduleTable}
//     (date, timer, schedule_name, note) VALUES (?, ?, ?, ?)''';
//
//     List<dynamic> params = [
//       schedule.date,
//       schedule.timer,
//       schedule.name,
//       schedule.note
//     ];
//     try {
//       final result = await db!.rawInsert(sql, params);
//       DatabaseCreator.databaseLog(
//           'Add Personal Schedule', sql, null, result, params);
//     } catch (e) {
//       debugPrint('ProviderOffline - addScheduleLessonProvider - error {$e}');
//     }
//   }
//
//   /// Select All School Schedules
//   Future<List<SchoolSchedule>> selectAllScheduleLessonProvider() async {
//     final dateSql =
//         '''SELECT * FROM ${DatabaseCreator.lessonTable} ORDER BY date ASC''';
//     final scheduleData = await db!.rawQuery(dateSql);
//     List<SchoolSchedule> allSchedules = [];
//     for (final node in scheduleData) {
//       // String date = node['date'].toString();
//       SchoolSchedule schedule = SchoolSchedule.fromJsonDb(node);
//       allSchedules.add(schedule);
//     }
//     return allSchedules;
//   }
//
//   /// Select All Personal Schedules
//   Future<List<PersonalSchedule>> selectAllPersonalScheduleProvider() async {
//
//     final dateSql =
//         '''SELECT * FROM ${DatabaseCreator.personaScheduleTable} ORDER BY date ASC''';
//     final scheduleData = await db!.rawQuery(dateSql);
//     List<PersonalSchedule> allSchedules = [];
//     for (final node in scheduleData) {
//       PersonalSchedule schedule = PersonalSchedule.fromJson(node);
//       allSchedules.add(schedule);
//     }
// //    debugPrint('RepositoryService - allSchedulesMap: ${allSchedulesMap.length}');
//     return allSchedules;
//   }
//
//   /// Select All School Schedules Of Date
//   Future<List<SchoolSchedule>> selectAllSchoolScheudleOfDateProvider(
//       String date) async {
//     final sql =
//         '''SELECT * FROM ${DatabaseCreator.lessonTable} WHERE date = ?''';
//     List<dynamic> params = [date];
//     final scheduleData = await db!.rawQuery(sql, params);
//     List<SchoolSchedule> schedules = [];
//     for (final node in scheduleData) {
//       SchoolSchedule schedule = SchoolSchedule.fromJsonDb(node);
//       schedules.add(schedule);
//     }
//     debugPrint('selectAllSchoolScheudleOfDateProvider - schedules: ${schedules.length}');
//     return schedules;
//   }
//
//   /// Select All Personal Schedules Of Date
//   Future<List<PersonalSchedule>> selectAllPersonalScheduleOfDateProvider(
//       String date) async {
//     final sql =
//         '''SELECT * FROM ${DatabaseCreator.personaScheduleTable} WHERE date = ?''';
//     List<dynamic> params = [date];
//     final scheduleData = await db!.rawQuery(sql, params);
//     List<PersonalSchedule> schedules = [];
//     for (final node in scheduleData) {
//       PersonalSchedule schedule = PersonalSchedule.fromJson(node);
//       schedules.add(schedule);
//     }
//     return schedules;
//   }
//
//   /// Update A Personal Schedule Data
//   Future<int> updatePersonalScheduleDataProvider(
//       PersonalSchedule schedule) async {
// //    debugPrint('ProviderOffline - updatePersonalScheduleData - scheduleId: {${schedule.id}}');
//     final data = await db!.update(
//         DatabaseCreator.personaScheduleTable, schedule.toJson(),
//         where: 'id = ?', whereArgs: [schedule.id]);
//     return data;
//   }
//
//   /// Delete Personal Schedule Data
//   Future<int> deletePersonalScheduleProvider(String? id) async {
//     final data = await db!.delete(DatabaseCreator.personaScheduleTable,
//         where: 'id = ?', whereArgs: [id]);
//     return data;
//   }
//
//   /// Delete All School Schedules Data
//   Future deleteAllSchoolScheduleProvider() async {
//     final sql = '''DELETE FROM ${DatabaseCreator.lessonTable}''';
//     await db!.rawQuery(sql);
//   }
// }
