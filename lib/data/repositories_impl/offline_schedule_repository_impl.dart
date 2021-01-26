import 'package:schedule/domain/repositories/offlineRepository.dart';
import 'package:schedule/src/models/model.dart';
import 'package:schedule/src/service/providers/providers.dart';

class OfflineRepositoryImpl extends OfflineRepository{
  ScheduleOfflineDataSource _scheduleOfflineDataSource = ScheduleOfflineDataSource();

  Future addScheduleLessonRepo(SchoolModel schedule) =>
      _scheduleOfflineDataSource.insertSchoolScheduleProvider(schedule);

  Future<List<SchoolModel>> fetchScheduleSchoolOfflineRepo() =>
      _scheduleOfflineDataSource.selectAllScheduleLessonProvider();

  Future<List<PersonalSchedule>> fetchAllPersonalScheduleRepo() =>
      _scheduleOfflineDataSource.selectAllPersonalScheduleProvider();

  Future<List<SchoolModel>> fetchAllSchoolScheduleOfDateRepo(String date) =>
      _scheduleOfflineDataSource.selectAllSchoolScheudleOfDateProvider(date);

  Future<List<PersonalSchedule>> fetchAllPersonalScheduleOfDateRepo(
      String date) =>
      _scheduleOfflineDataSource.selectAllPersonalScheduleOfDateProvider(date);

  Future addPersonalScheduleRepo(PersonalSchedule schedule) =>
      _scheduleOfflineDataSource.insertPersonalScheduleProvider(schedule);

  Future<int> updatePersonalScheduleData(PersonalSchedule schedule) =>
      _scheduleOfflineDataSource.updatePersonalScheduleDataProvider(schedule);

  Future deleteAllSchoolSchedulesRepo() =>
      _scheduleOfflineDataSource.deleteAllSchoolScheduleProvider();

  Future<int> deletePersonalScheduleRepo(String id) =>
      _scheduleOfflineDataSource.deletePersonalScheduleProvider(id);
}
