import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:schedule/common/config/default_env.dart';
import 'package:schedule/domain/entities/personal_schedule_entities.dart';
import 'package:schedule/domain/entities/school_schedule_entities.dart';
class LocalConfig {
  late Box<PersonalScheduleEntities> personalBox;
  late Box<SchoolSchedule> scheduleBox;
  Future<void> init() async {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(PersonalScheduleEntitiesAdapter());
    Hive.registerAdapter(SchoolScheduleEntitiesAdapter());
    personalBox = await Hive.openBox(DefaultEnv.personaScheduleTable);
    scheduleBox = await Hive.openBox(DefaultEnv.scheduleTable);
  }

  void dispose() {
    personalBox.compact();
    scheduleBox.compact();
    Hive.close();
  }
}
