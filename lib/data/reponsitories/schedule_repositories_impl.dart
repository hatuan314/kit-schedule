import 'package:schedule/data/local_data_source/schedule_hive.dart';
import 'package:schedule/data/remote/data_remote.dart';
import 'package:schedule/domain/entities/school_schedule_entities.dart';
import 'package:schedule/domain/repositories/schedule_repositories.dart';

class ScheduleRepositoriesImpl extends ScheduleRepositories {
  final DataRemote dataRemote;
  final ScheduleHive scheduleHive;

  ScheduleRepositoriesImpl(this.dataRemote, this.scheduleHive);

  @override
  Future<Map<String, dynamic>?> fetchScheduleSchoolDataDioRepo(
      String account, String password) {
    return dataRemote.fetchScheduleSchoolDataDio(account, password);
  }

  @override
  Future<Map> fetchScheduleSchoolDataFirebaseRepo(String msv) {
    return dataRemote.fetchScheduleSchoolDataFirebase(msv);
  }

  @override
  Future<String> syncScheduleSchoolDataFirebaseRepo(String msv, Map data) {
    return dataRemote.syncScheduleSchoolDataFirebase(msv, data);
  }

  @override
  Future<void> insertSchoolScheduleLocal(List<SchoolSchedule> data) async {
    await scheduleHive.insertSchoolScheduleProvider(data);
  }

  @override
  Future<List<SchoolSchedule>> fetchScheduleSchoolLocal() {
    return scheduleHive.selectAllScheduleLessonProvider();
  }

  @override
  Future<void> deleteAllSchoolSchedulesLocal() async {
    await scheduleHive.deleteAllSchoolSchedulesRepo();
  }

  Future<void> updateAllSchoolSchedulesLocal(List<SchoolSchedule> data) async {
    await scheduleHive.updateAllSchoolSchedulesRepo(data);
  }
}
