import 'package:flutter/cupertino.dart';
import 'package:schedule/src/models/model.dart';

class SchoolEntity{
  String date;
  String lesson;
  String subject;
  String address;

  SchoolEntity({@required this.date,@required  this.lesson,@required  this.subject,@required  this.address});

  toModel() => SchoolModel(date: date,lesson: lesson,subject: subject,address: address);

  @override
  String toString() {
    return 'SchoolEntity{date: $date, lesson: $lesson, subject: $subject, address: $address}';
  }
}