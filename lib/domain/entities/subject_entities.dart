import 'package:hive/hive.dart';

part 'subject_entities.g.dart';

@HiveType(typeId: 2)
class SubjectEntities{
  @HiveField(0)
  int? subjectId;
  @HiveField(1)
  String? subjectName;
  @HiveField(2)
  int? credits;

  SubjectEntities({  this.subjectId,  this.subjectName,  this.credits});

  SubjectEntities.fromJson(Map<String, dynamic> data) {
    this.subjectId = data['id'];
    this.subjectName = data['name'];
    this.credits = data['credits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.subjectId;
    data['name'] = this.subjectName;
    data['credits'] = this.credits;
    return data;
  }
}