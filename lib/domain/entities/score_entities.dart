
import 'package:hive/hive.dart';
part 'score_entities.g.dart';
@HiveType(typeId: 3)
class ScoreEntities {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? subject;
  @HiveField(2)
  double? scoreIn4;
  @HiveField(3)
  double? scoreIn10;
  @HiveField(4)
  String? letter;
  @HiveField(5)
  int? credits;

  ScoreEntities(
  { this.id,
    this.credits, this.subject, this.scoreIn4, this.scoreIn10, this.letter});

  ScoreEntities.fromJson(Map<String, dynamic> data) {
    this.id = data['id'];
    this.subject = data['subject'];
    this.credits = data['credits'];
    this.scoreIn4 = data['scoreIn4'];
    this.scoreIn10 = data['scoreIn10'];
    this.letter = data['letter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['subject'] = this.subject;
    data['credits'] = this.credits;
    data['scoreIn4'] = this.scoreIn4;
    data['scoreIn10'] = this.scoreIn10;
    data['letter']= this.letter;
    return data;
  }
}