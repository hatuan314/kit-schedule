import 'dart:convert';
import 'dart:io';

import 'package:schedule/data/repositories_impl/offline_schedule_repository_impl.dart';
import 'package:schedule/domain/entities/school_entity.dart';
import 'package:schedule/domain/repositories/school_schedule_repository.dart';
import 'package:schedule/src/models/school_schedule.dart';
import 'package:schedule/src/service/services.dart';
import 'package:schedule/src/utils/convert.dart';

class ScheduleUseCase {
  final SchoolScheduleRepository schoolScheduleRepository;
  final OfflineRepositoryImpl repositoryOffline;

  ScheduleUseCase({this.repositoryOffline, this.schoolScheduleRepository});

  Future<List<SchoolEntity>> initData() async {
    List<SchoolEntity> listSchoolEntity = await repositoryOffline
        .fetchScheduleSchoolOfflineRepo();
    return listSchoolEntity;
  }

  Future<List<SchoolEntity>> getScheduleFromDate(
  Map<DateTime, List<SchoolEntity>> mapData, DateTime date) async {
    return mapData[Convert.dateConvert(date)];
  }

  Map<DateTime, List<SchoolEntity>> addSelectedDay(Map<DateTime, List<SchoolEntity>> data, DateTime selectedDay)
  {
    if(data[selectedDay]==null)
      data[selectedDay]=List();
  }
  Map<DateTime, List<SchoolEntity>> mapAllListEntityToMap(
      List<SchoolEntity> listEntity) {
    Map<DateTime, List<SchoolEntity>> mapData = Map();
    listEntity.forEach((schoolEntity) {
      DateTime dateTime = Convert.dateConvert(
          DateTime.fromMillisecondsSinceEpoch(int.parse(schoolEntity.date)));
      if (mapData[dateTime] ==
          null) { // nếu data tại Map[Date] RỖNG THÌ khởi tạo list() cho nó
        mapData[dateTime] = List();
      }
      mapData[dateTime]
          .add(schoolEntity);
      });
        return mapData;
    }
}