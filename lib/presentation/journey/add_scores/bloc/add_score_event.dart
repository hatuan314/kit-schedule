import 'package:equatable/equatable.dart';
import 'package:schedule/domain/entities/subject_entities.dart';

abstract class AddScoreEvent extends Equatable{

}

class SetUpEvent extends AddScoreEvent{
  @override
  List<Object?> get props => [ ];
}

class EditGradeEvent extends AddScoreEvent{
  final String grade;

  EditGradeEvent({required this.grade});

  @override
  List<Object?> get props => [this.grade];
}

class EditComponentScore1Event extends AddScoreEvent{
  final String componentScore1;

  EditComponentScore1Event({required this.componentScore1});

  @override
  List<Object?> get props => [this.componentScore1];
}

class EditComponentScore2Event extends AddScoreEvent{
  final String componentScore2;

  EditComponentScore2Event({required this.componentScore2});

  @override
  List<Object?> get props => [this.componentScore2];
}
class EditFinalTermScoreEvent extends AddScoreEvent{
  final String finalTermScore;

  EditFinalTermScoreEvent({required this.finalTermScore});

  @override
  List<Object?> get props => [this.finalTermScore];
}

class EditSubjectEvent extends AddScoreEvent{
  final SubjectEntities subject;

  EditSubjectEvent({required this.subject});

  @override
  List<Object?> get props => [this.subject];
}