import 'package:schedule/domain/entities/school_schedule_entities.dart';

abstract class ScheduleRepositories {
  Future<Map<String, dynamic>?> fetchScheduleSchoolDataDioRepo(
      String account, String password);

  Future<String> syncScheduleSchoolDataFirebaseRepo(String msv, Map data);

  Future<Map> fetchScheduleSchoolDataFirebaseRepo(String msv);

  Future<void> insertSchoolScheduleLocal(List<SchoolSchedule> data);

  Future<List<SchoolSchedule>> fetchScheduleSchoolLocal();

  Future<void> deleteAllSchoolSchedulesLocal();

  Future<void> updateAllSchoolSchedulesLocal(List<SchoolSchedule> data);
}
