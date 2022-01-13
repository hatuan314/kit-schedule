import 'package:equatable/equatable.dart';
import 'package:schedule/common/enums/view_state.dart';
import 'package:schedule/domain/entities/subject_entities.dart';

class AddScoreState extends Equatable {
  final String grade;
  final SubjectEntities subject;
  final List<SubjectEntities> subjectsList;
  final int credits;
  final double componentScore1;
  final double componentScore2;
  final double finalTermScore;
  final double avgScore;
  final ViewState viewState;

  AddScoreState(
      {required this.grade,
      required this.subject,
      required this.subjectsList,
      required this.credits,
      required this.componentScore1,
      required this.componentScore2,
      required this.finalTermScore,
      required this.avgScore,
      required this.viewState});

  AddScoreState update(
          {String? grade,
          SubjectEntities? subject,
          List<SubjectEntities>? subjectsList,
          int? credits,
          double? componentScore1,
          double? componentScore2,
          double? finalTermScore,
          double? avgScore,
          ViewState? viewState}) =>
      AddScoreState(
          grade: grade ?? this.grade,
          subject: subject ?? this.subject,
          subjectsList: subjectsList ?? this.subjectsList,
          credits: credits ?? this.credits,
          componentScore1: componentScore1 ?? this.componentScore1,
          componentScore2: componentScore2 ?? this.componentScore2,
          finalTermScore: finalTermScore ?? this.finalTermScore,
          avgScore: avgScore ?? this.avgScore,
          viewState: viewState ?? this.viewState);

  @override
  List<Object?> get props => [
        this.grade,
        this.subject,
        this.subjectsList,
        this.credits,
        this.componentScore1,
        this.componentScore2,
        this.finalTermScore,
        this.avgScore,
        this.viewState
      ];
}
