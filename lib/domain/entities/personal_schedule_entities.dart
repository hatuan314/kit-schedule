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
  @HiveField(7)
  bool? isSynchronized;
  PersonalScheduleEntities(
      {this.date,
      this.name,
      this.timer,
      this.note,
      this.createAt,
      this.updateAt,
      this.isSynchronized,
      this.id}) {
    this.createAt = createAt ?? DateTime.now().millisecondsSinceEpoch.toString();
    this.updateAt = updateAt ?? DateTime.now().millisecondsSinceEpoch.toString();
  }
  PersonalScheduleEntities.fromJson(Map<dynamic, dynamic> data, this.createAt) {
    this.date = data['date'];
    this.name = data['name'];
    this.timer = data['timer'];
    this.note = data['note'];
    this.updateAt = data['updateAt'];
  }
  toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = this.date;
    data['name'] = this.name;
    data['timer'] = this.timer;
    data['note'] = this.note;
    data['updateAt'] = this.updateAt;
    return data;
  }
}
