import 'package:schedule/domain/entities/score_entities.dart';
import 'package:schedule/domain/repositories/scores_repositories.dart';

class ScoresUsecase {
  final ScoresRepositories scoresRepositories;

  ScoresUsecase({required this.scoresRepositories});

  Future<void> deleteScore(ScoreEntities scoreEntities) async {
    return await scoresRepositories.deleteScore(scoreEntities);
  }

  Future<List<ScoreEntities>> fetchAllScores() async{
    return await scoresRepositories.fetchAllScores();
  }
  
  Future<void> insertScore(ScoreEntities scoreEntities)async {
    return await scoresRepositories.insertScore(scoreEntities);
  }
  
  Future<void> insertScoresList(List<ScoreEntities> scoresEntities)async {
    return await scoresRepositories.insertScoresList(scoresEntities);
  }
}