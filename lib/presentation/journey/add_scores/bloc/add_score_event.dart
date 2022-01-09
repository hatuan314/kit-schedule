import 'package:equatable/equatable.dart';
import 'package:schedule/domain/entities/subject_entities.dart';

abstract class AddScoreEvent extends Equatable {}

class SetUpEvent extends AddScoreEvent {
  @override
  List<Object?> get props => [];
}

class EditSubjectEvent extends AddScoreEvent {
  final SubjectEntities subject;

  EditSubjectEvent({required this.subject});

  @override
  List<Object?> get props => [this.subject];
}

class CalculateScoreEvent extends AddScoreEvent {
  final double componentScore1;
  final double componentScore2;
  final double finalTermScore;

  CalculateScoreEvent(
      {required this.componentScore1,
      required this.componentScore2,
      required this.finalTermScore});

  @override
  List<Object?> get props =>
      [this.finalTermScore, this.componentScore1, this.componentScore2];
}

// class SearchSubjectEvent extends AddScoreEvent {
//   final String keyword;
//
//   SearchSubjectEvent({required this.keyword});
//   @override
//   List<Object?> get props => [this.keyword];
// }
//
// class UpdateSubjectFromFirebaseEvent extends AddScoreEvent {
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }

class SaveNewScoreEvent extends AddScoreEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
