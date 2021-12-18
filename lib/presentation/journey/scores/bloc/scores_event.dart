import 'package:equatable/equatable.dart';
import 'package:schedule/domain/entities/score_entities.dart';

abstract class ScoresEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddNewScoreEvent extends ScoresEvent {
  final ScoreEntities score;

  AddNewScoreEvent(this.score);

  @override
  // TODO: implement props
  List<Object?> get props => [score];
}

class DeleteScoreEvent extends ScoresEvent {
  final ScoreEntities score;

  DeleteScoreEvent(this.score);

  @override
  // TODO: implement props
  List<Object?> get props => [score];
}

class InitEvent extends ScoresEvent {}

class LoadScoresEvent extends ScoresEvent {}

class CalculateGpaScoreEvent extends ScoresEvent {}
