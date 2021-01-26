import 'dart:convert';
import 'dart:io';

import 'package:schedule/domain/entities/school_entity.dart';
import 'package:schedule/domain/repositories/school_schedule_repository.dart';
import 'package:schedule/src/models/school_schedule.dart';

class SchoolScheduleRepositoryImpl implements SchoolScheduleRepository {

  @override
  Future<List<SchoolEntity>> fetchAllSchoolSchedule() async {
    String dataJson = await new File('${Directory.current.path}/test/response.json').readAsString();
    Map dataMap = json.decode(dataJson);
    Map scheduleDataMap = dataMap['schedule']['dataJson'];
    List dates = scheduleDataMap.keys.toList();
    List<SchoolEntity> schoolSchedule = List();
    try {
      dates.forEach((date) {
        if (scheduleDataMap[date] != null || scheduleDataMap[date].length > 0)
          scheduleDataMap[date].forEach((scheduleJson) async {
            SchoolModel schoolModel =
            SchoolModel.fromJsonApi(scheduleJson, date);
            schoolSchedule.add(schoolModel.toEntity());
            //await _offline.addScheduleLessonRepo(schoolSchedule);
          });
      });
    } catch (e) {
      print('RegisterBloc - saveSchoolSchedule - error: {$e}');
    }
    return schoolSchedule;
  }

  @override
  List<SchoolEntity> fetchAllSchoolScheduleOfDate(List<SchoolEntity> schoolScheduleEntity, String date) {
    List<SchoolEntity> listSchoolScheduleOfDate = List();
    for(SchoolEntity schoolEntity in schoolScheduleEntity)
      {
        if(schoolEntity.date == date)
          {
            listSchoolScheduleOfDate.add(schoolEntity);
          }
      }
    return listSchoolScheduleOfDate;
  }


}