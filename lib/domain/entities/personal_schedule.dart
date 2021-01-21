import 'package:flutter/material.dart';
import 'package:schedule/data/model/personal_schedule_model.dart';

class PersonalSchedule {
  final String id;
  final String title;
  final String note;
  final String date;
  final String times;

  PersonalSchedule(
      {this.id,@required this.title,@required  this.note,@required  this.times,@required  this.date});
  toModel() => PersonalScheduleModel(id: id, title: title, note: note, date: date, times: times);
  @override
  String toString() {
    return "title : $title, note : $note, date : $date, time : $times";
  }
}