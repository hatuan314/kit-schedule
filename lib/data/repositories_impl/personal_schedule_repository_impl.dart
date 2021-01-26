import 'package:flutter/material.dart';
import 'package:schedule/data/data_sources/local_data_sources/personal_schedule_local_data_sources.dart';
import 'package:schedule/domain/entities/personal_schedule.dart';
import 'package:schedule/domain/repositories/personal_schedule_repository.dart';

class PersonalScheduleRepositoryImpl implements PersonalScheduleRepository{
  final PersonalScheduleLocalDataSource dataSource;

  PersonalScheduleRepositoryImpl({@required this.dataSource});
  @override
  Future addPersonalSchedule(PersonalScheduleEntity schedule) async{
    dataSource.insertPersonalSchedule(schedule.toModel());
  }


  @override
  Future<int> deletePersonalSchedule(String id) async {
    return dataSource.deletePersonalSchedule(id);
  }

  @override
  Future<List<PersonalScheduleEntity>> fetchAllPersonalSchedule() async{
    return await dataSource.selectAllPersonalSchedule();
  }

  @override
  Future<List<PersonalScheduleEntity>> fetchAllPersonalScheduleOfDate(String date)async {
    return await dataSource.selectAllPersonalScheduleOfDate(date);
  }

  @override
  Future<int> updatePersonalScheduleData(PersonalScheduleEntity schedule)async {
    return await dataSource.updatePersonalScheduleData(schedule.toModel());
  }

}