// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:schedule/data/repositories_impl/offline_schedule_repository_impl.dart';
import 'package:schedule/data/repositories_impl/school_schedule_repository_impl.dart';
import 'package:schedule/domain/entities/school_entity.dart';
import 'package:schedule/domain/repositories/school_schedule_repository.dart';
import 'package:schedule/domain/use_cases/schedule_use_case.dart';
import 'package:schedule/injection.dart';
import 'dart:convert';
import 'package:schedule/src/models/account_model.dart';
import 'package:schedule/src/models/school_schedule.dart';

import 'package:schedule/src/service/repositors/online/repository_online.dart';
saveScheduleSchool(Map scheduleDataMap) async {
  OfflineRepositoryImpl _offline = OfflineRepositoryImpl();
  List dates = scheduleDataMap.keys.toList();
  try {
    dates.forEach((date) {
      if (scheduleDataMap[date] != null || scheduleDataMap[date].length > 0)
        scheduleDataMap[date].forEach((scheduleJson) async {
          SchoolModel schoolSchedule =
          SchoolModel.fromJsonApi(scheduleJson, date);
          print('${schoolSchedule.toString()}');
          //await _offline.addScheduleLessonRepo(schoolSchedule);
        });
    });
  } catch (e) {
    print('RegisterBloc - saveSchoolSchedule - error: {$e}');
  }
}
void main() {


  test('get data from api', () async {
    final AccountModel accountModel =
    AccountModel(account: 'CT030419', password: 'p02t08c2019');
    RepositoryOnline _online = RepositoryOnline();
    var dataJson =
        await _online.fetchScheduleSchoolDataRepo(accountModel);
    print('$dataJson');
  });
  test('convert json to DB',() async {
    String dataJson = await new File('${Directory.current.path}/test/response.json').readAsString();
    Map data = json.decode(dataJson);
    //saveScheduleSchool(data['schedule']['dataJson']);
  });

  test('get data from json', () async {
    /*SchoolScheduleRepositoryImpl scheduleRepositoryImpl = SchoolScheduleRepositoryImpl();
    List<SchoolEntity> se= await scheduleRepositoryImpl.fetchAllSchoolSchedule();
    print('$se');
    */
    configureDependencies();

    ScheduleUseCase scheduleUseCase = getIt<ScheduleUseCase>();
    List<SchoolEntity> list= await scheduleUseCase.initData();
    List<SchoolEntity> list2schoolScheduleEntity= await scheduleUseCase.getScheduleFromDate(list, '1611416400000');
    print('${list2schoolScheduleEntity}');
  });
}
