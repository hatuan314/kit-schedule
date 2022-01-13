import 'package:schedule/common/config/local_config.dart';
import 'package:schedule/domain/entities/score_entities.dart';

class ScoresHive{
  final LocalConfig hiveConfig;

  ScoresHive( {required this.hiveConfig});

  Future<void> insertScoresList(List<ScoreEntities> scoresEntities) async
  {
    await hiveConfig.scoresBox.clear();
    await hiveConfig.scoresBox.addAll(scoresEntities);
  }

  Future<void> insertScore(ScoreEntities scoreEntities) async
  {
     await hiveConfig.scoresBox.put(scoreEntities.id, scoreEntities);
  }

  Future<List<ScoreEntities>> fetchAllScores() async
  {
    return await hiveConfig.scoresBox.values.toList();
  }

  Future<void> deleteScore(ScoreEntities scoreEntities) async
  {
    await hiveConfig.scoresBox..delete(scoreEntities.id);
  }
}