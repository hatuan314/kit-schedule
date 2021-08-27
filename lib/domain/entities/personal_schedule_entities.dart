import 'package:hive/hive.dart';
part 'personal_schedule_entities.g.dart';

@HiveType(typeId: 1)
class PersonalScheduleEntities {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? date;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? timer;
  @HiveField(4)
  String? note;
  @HiveField(5)
  String? createAt;
  @HiveField(6)
  String? updateAt;

  PersonalScheduleEntities(
      {this.date,
      this.name,
      this.timer,
      this.note,
      this.createAt,
      this.updateAt,
      this.id}){
   this.createAt=createAt??DateTime.now().toString();
   this.updateAt=updateAt??DateTime.now().toString();
  }
}
