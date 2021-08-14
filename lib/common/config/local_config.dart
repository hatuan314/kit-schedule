import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:schedule/common/config/default_env.dart';
import 'package:schedule/models/model.dart';

class LocalConfig {
  Box<PersonalSchedule>? personalBox;
  Box<SchoolSchedule>? scheduleBox;
  Future<void> init() async {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    personalBox = await Hive.openBox(DefaultEnv.personaScheduleTable);
    scheduleBox = await Hive.openBox(DefaultEnv.scheduleTable);
  }

  void dispose() {
    personalBox!.compact();
    scheduleBox!.compact();
    Hive.close();
  }
}
