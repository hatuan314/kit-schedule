import 'package:schedule/domain/entities/personal_schedule_entities.dart';

abstract class PersonalRepositories {
  Future<void> insertPersonalScheduleLocal(
      PersonalScheduleEntities personalScheduleEntities);
  Future<List<PersonalScheduleEntities>> fetchAllPersonalScheduleOfDateLocal(String date);
  Future<List<PersonalScheduleEntities>> fetchAllPersonalScheduleRepoLocal();
  Future<void> deleteAllSchoolPersonalLocal();
  Future<int> deletePersonalScheduleLocal(PersonalScheduleEntities personal);
  Future<int> updatePersonalScheduleDataLocal(
      PersonalScheduleEntities personal);
}
