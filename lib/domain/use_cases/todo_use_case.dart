import 'package:flutter/material.dart';
import 'package:schedule/domain/entities/personal_schedule.dart';
import 'package:schedule/domain/repositories/personal_schedule_repository.dart';

class TodoUseCase {
  final PersonalScheduleRepository repository;
  TodoUseCase({@required this.repository});

  Future createTodo(PersonalSchedule schedule) async{
    await repository.addPersonalSchedule(schedule);
  }
  Future<List<PersonalSchedule>> fetchPersonalScheduleOfDate(String date) async{
    return await repository.fetchAllPersonalScheduleOfDate(date);
  }

}