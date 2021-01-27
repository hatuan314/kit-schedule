import 'package:flutter/material.dart';
import 'package:schedule/domain/entities/personal_schedule.dart';
import 'package:schedule/domain/repositories/personal_schedule_repository.dart';

class SearchUseCase {
  final PersonalScheduleRepository personalScheduleRepository;

  SearchUseCase({@required this.personalScheduleRepository});

  Future<List> getListSchedule() async{
    List<PersonalScheduleEntity> personalList = await personalScheduleRepository.fetchAllPersonalSchedule();
    return personalList;
  }
  Future<List> getListScheduleWithEvent(String key) async{
    List schedule = List();
    
    return schedule;
  }

}