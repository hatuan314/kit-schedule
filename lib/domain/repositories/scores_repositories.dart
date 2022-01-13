import 'package:schedule/domain/entities/score_entities.dart';

abstract class ScoresRepositories{
  Future<void> insertScoresList(List<ScoreEntities> scoresEntities);

  Future<void> insertScore(ScoreEntities scoreEntities);

  Future<List<ScoreEntities>> fetchAllScores();

  Future<void> deleteScore(ScoreEntities scoreEntities);
}