import 'package:hive/hive.dart';

part 'school_schedule_entities.g.dart';

@HiveType(typeId: 0)
class SchoolSchedule {
  @HiveField(0)
  String? date;
  @HiveField(1)
  String? lesson;
  @HiveField(2)
  String? subject;
  @HiveField(3)
  String? address;
  @HiveField(4)
  String? id;

  SchoolSchedule(this.date, this.lesson, this.subject, this.address, this.id);

  SchoolSchedule.fromJsonApi(Map<String, dynamic> data, this.date) {
    this.subject = data['subject'];
    this.lesson = data['lesson'];
    this.address = data['address'];
  }

  SchoolSchedule.fromJsonDb(Map<String, dynamic> data) {
    this.date = data['date'];
    this.subject = data['subject_name'];
    this.lesson = data['lesson'];
    this.address = data['address'];
  }

  toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = this.date;
    data['address'] = this.address;
    data['lesson'] = this.lesson;
    data['subject'] = this.subject;
    return data;
  }
}
