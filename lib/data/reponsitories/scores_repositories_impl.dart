import 'package:schedule/data/local_data_source/scores_hive.dart';
import 'package:schedule/domain/entities/score_entities.dart';
import 'package:schedule/domain/repositories/scores_repositories.dart';

class ScoresRepositoriesImpl extends ScoresRepositories{
  final ScoresHive scoresHive;


  ScoresRepositoriesImpl({required this.scoresHive});

  @override
  Future<void> deleteScore(ScoreEntities scoreEntities) async {
    return await scoresHive.deleteScore(scoreEntities);
  }

  @override
  Future<List<ScoreEntities>> fetchAllScores() async{
    return await scoresHive.fetchAllScores();
  }

  @override
  Future<void> insertScore(ScoreEntities scoreEntities)async {
    return await scoresHive.insertScore(scoreEntities);
  }

  @override
  Future<void> insertScoresList(List<ScoreEntities> scoresEntities)async {
    return await scoresHive.insertScoresList(scoresEntities);
  }

}