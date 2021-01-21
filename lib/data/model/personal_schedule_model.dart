import 'package:flutter/material.dart';
import 'package:schedule/domain/entities/personal_schedule.dart';

class PersonalScheduleModel extends PersonalSchedule {
  PersonalScheduleModel(
      {@required String id,
      @required String title,
      @required String note,
      @required String date,
      @required String times})
      : super(id: id, title: title, note: note, date: date, times: times);

  factory PersonalScheduleModel.fromJson(Map<String, dynamic> data) {
    return PersonalScheduleModel(
        id: data['id'],
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
