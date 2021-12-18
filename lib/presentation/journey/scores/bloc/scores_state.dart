import 'package:equatable/equatable.dart';
import 'package:schedule/domain/entities/score_entities.dart';

class ScoresState extends Equatable {
  final String studentId;
  final List<ScoreEntities> scores;
  final double gpa;
  final bool isLogin;

  ScoresState(
      {required this.studentId,
      required this.scores,
      required this.gpa,
      required this.isLogin});

  ScoresState update(
          {String? studentId,
          List<ScoreEntities>? scores,
          double? gpa,
          bool? isLogin}) =>
      ScoresState(
          studentId: studentId ?? this.studentId,
          scores: scores ?? this.scores,
          gpa: gpa ?? this.gpa,
          isLogin: isLogin ?? this.isLogin);

  @override
  // TODO: implement props
  List<Object?> get props => [studentId, scores, gpa, isLogin];
}
