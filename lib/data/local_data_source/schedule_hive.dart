import 'package:schedule/common/config/local_config.dart';
import 'package:schedule/domain/entities/school_schedule_entities.dart';

class ScheduleHive {
  final LocalConfig hiveConfig;

  ScheduleHive(this.hiveConfig);
  Future<void> insertSchoolScheduleProvider(List<SchoolSchedule> data) async {
    await hiveConfig.scheduleBox.addAll(data);
  }

  Future<List<SchoolSchedule>> selectAllScheduleLessonProvider() async {
    final result = hiveConfig.scheduleBox.values.toList();
    result.sort((a, b) => int.parse(a.date!).compareTo(int.parse(b.date!)));
    return result;
  }
  Future<void> deleteAllSchoolSchedulesRepo() async {
    await hiveConfig.scheduleBox.clear();
  }
}
