import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:schedule/common/config/default_env.dart';
import 'package:schedule/domain/entities/personal_schedule_entities.dart';
import 'package:schedule/domain/entities/school_schedule_entities.dart';
import 'package:schedule/domain/entities/score_entities.dart';
import 'package:schedule/domain/entities/subject_entities.dart';

class LocalConfig {
  late Box<PersonalScheduleEntities> personalBox;
  late Box<SchoolSchedule> scheduleBox;
  late Box<SubjectEntities> subjectBox;
  late Box<ScoreEntities> scoresBox;

  Future<void> init() async {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(PersonalScheduleEntitiesAdapter());
    Hive.registerAdapter(SchoolScheduleAdapter());
    Hive.registerAdapter(SubjectEntitiesAdapter());
    Hive.registerAdapter(ScoreEntitiesAdapter());
    subjectBox = await Hive.openBox(DefaultEnv.subjectTable);
    personalBox = await Hive.openBox(DefaultEnv.personaScheduleTable);
    scheduleBox = await Hive.openBox(DefaultEnv.scheduleTable);
    scoresBox = await Hive.openBox(DefaultEnv.scoresTable);
  }

  void dispose() {
    personalBox.compact();
    scheduleBox.compact();
    subjectBox.compact();
    scoresBox.compact();
    Hive.close();
  }
}
