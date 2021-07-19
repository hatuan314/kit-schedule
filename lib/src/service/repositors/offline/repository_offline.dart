import 'package:schedule/src/models/model.dart';
import 'package:schedule/src/service/providers/providers.dart';

class RepositoryOffline {
  ProviderOffline _providerOffline = ProviderOffline();

  Future addScheduleLessonRepo(SchoolSchedule schedule) =>
      _providerOffline.insertSchoolScheduleProvider(schedule);

  Future<List<SchoolSchedule>> fetchScheduleSchoolOfflineRepo() =>
      _providerOffline.selectAllScheduleLessonProvider();

  Future<List<PersonalSchedule>> fetchAllPersonalScheduleRepo() =>
      _providerOffline.selectAllPersonalScheduleProvider();

  Future<List<SchoolSchedule>> fetchAllSchoolScheduleOfDateRepo(String date) =>
      _providerOffline.selectAllSchoolScheudleOfDateProvider(date);

  Future<List<PersonalSchedule>> fetchAllPersonalScheduleOfDateRepo(
          String date) =>
      _providerOffline.selectAllPersonalScheduleOfDateProvider(date);

  Future addPersonalScheduleRepo(PersonalSchedule schedule) =>
      _providerOffline.insertPersonalScheduleProvider(schedule);

  Future<int> updatePersonalScheduleData(PersonalSchedule schedule) =>
      _providerOffline.updatePersonalScheduleDataProvider(schedule);

  Future deleteAllSchoolSchedulesRepo() =>
      _providerOffline.deleteAllSchoolScheduleProvider();

  Future<int> deletePersonalScheduleRepo(String? id) =>
      _providerOffline.deletePersonalScheduleProvider(id);
}
