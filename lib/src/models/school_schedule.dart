import 'package:flutter/cupertino.dart';
import 'package:schedule/domain/entities/school_entity.dart';

class SchoolModel extends SchoolEntity {


  SchoolModel({
    @required String subject,
    @required String address,
    @required String date,
    @required String lesson})
      : super(subject: subject, address: address, date: date, lesson: lesson);

  SchoolModel.fromJsonApi(Map<String, dynamic> data, String date) {
    this.date = date;
    this.subject = data['subject'];
    this.lesson = data['lesson'];
    this.address = data['address'];
  }

  SchoolModel.fromJsonDb(Map<String, dynamic> data) {
    this.date = data['date'];
    this.subject = data['subject_name'];
    this.lesson = data['lesson'];
    this.address = data['address'];
  }
  SchoolEntity toEntity()
  {
    return SchoolEntity(date: this.date, lesson: this.lesson, subject: this.subject, address: this.address);
  }
  toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = this.date;
    data['address'] = this.address;
    data['lesson'] = this.lesson;
    data['subject'] = this.subject;
    return data;
  }
  @override
  String toString() {
    return 'SchoolScheduleEntity{date: $date, lesson: $lesson, subject: $subject, address: $address}';
  }

}
