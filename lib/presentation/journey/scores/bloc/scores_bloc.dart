import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/domain/entities/score_entities.dart';
import 'package:schedule/domain/usecase/scores_usecase.dart';
import 'package:schedule/presentation/journey/scores/bloc/scores_event.dart';
import 'package:schedule/presentation/journey/scores/bloc/scores_state.dart';
import 'package:schedule/service/share_service.dart';

class ScoresBloc extends Bloc<ScoresEvent, ScoresState> {
  ScoresBloc({required this.scoresUsecase})
      : super(ScoresState(studentId: '', scores: [], gpa: 0, isLogin: false));
  final ScoresUsecase scoresUsecase;
  ShareService _shareService = ShareService();

  @override
  Stream<ScoresState> mapEventToState(ScoresEvent event) async* {
    if (event is CalculateGpaScoreEvent) {
      yield* _mapCalculateGpaScoreEventToState(event);
    } else if (event is DeleteScoreEvent) {
      yield* _mapDeleteScoreEventToState(event);
    } else if (event is InitEvent) {
      yield* _mapInitEventToState(event);
    } else if (event is LoadScoresEvent) {
      yield* _mapLoadScoresEventToState(event);
    }
  }

  Stream<ScoresState> _mapCalculateGpaScoreEventToState(
      CalculateGpaScoreEvent event) async* {
    double sumScores = 0;
    double sumCredits = 0;
    double gpa = 0;
    for (ScoreEntities scoreEntities in state.scores) {
      sumScores += (scoreEntities.scoreIn4 ?? 0) * (scoreEntities.credits ?? 0);
      sumCredits += scoreEntities.credits ?? 0;
    }
    if (sumCredits != 0) {
      gpa = double.parse((sumScores / sumCredits).toStringAsFixed(2));
    }
    yield state.update(gpa: gpa);
  }

  Stream<ScoresState> _mapDeleteScoreEventToState(
      DeleteScoreEvent event) async* {
    await scoresUsecase.deleteScore(event.score);
    final List<ScoreEntities> newScoresList = [];
    newScoresList.addAll(state.scores);
    newScoresList.remove(event.score);
    yield state.update(scores: newScoresList);
  }

  Stream<ScoresState> _mapInitEventToState(InitEvent event) async* {
    yield state.update(
        studentId: (await ShareService().getUsername() as String),
        isLogin: await _shareService.getIsSaveData());
  }

  Stream<ScoresState> _mapLoadScoresEventToState(LoadScoresEvent event) async* {
    final scoresList = await scoresUsecase.fetchAllScores();
    yield state.update(scores: scoresList);
  }
}
