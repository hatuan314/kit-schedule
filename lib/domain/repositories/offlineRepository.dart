import 'package:schedule/src/models/model.dart';
import 'package:schedule/src/service/providers/providers.dart';

abstract class OfflineRepository {

  Future addScheduleLessonRepo(SchoolModel schedule);

  Future<List<SchoolModel>> fetchScheduleSchoolOfflineRepo() ;

  Future<List<PersonalSchedule>> fetchAllPersonalScheduleRepo();

  Future<List<SchoolModel>> fetchAllSchoolScheduleOfDateRepo(String date);

  Future<List<PersonalSchedule>> fetchAllPersonalScheduleOfDateRepo(
      String date);

  Future addPersonalScheduleRepo(PersonalSchedule schedule);

  Future<int> updatePersonalScheduleData(PersonalSchedule schedule);

  Future deleteAllSchoolSchedulesRepo();

  Future<int> deletePersonalScheduleRepo(String id);
}
