import 'package:flutter/material.dart';
import 'package:schedule/domain/entities/personal_schedule.dart';

class PersonalScheduleModel extends PersonalSchedule {
  PersonalScheduleModel(
      {@required String title,
      @required String note,
      @required String date,
      @required String times})
      : super(title: title, note: note, date: date, times: times);

  factory PersonalScheduleModel.fromJson(Map<String, dynamic> data) {
    return PersonalScheduleModel(
        title: data['title'],
        note: data['note'],
        date: data['date'],
        times: data['time']);
  }

  toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['note'] = note;
    data['date'] = date;
    data['time'] = times;
  }
}