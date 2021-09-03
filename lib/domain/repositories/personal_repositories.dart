import 'package:schedule/domain/entities/personal_schedule_entities.dart';

abstract class PersonalRepositories {
  Future<void> insertPersonalScheduleLocal(
      PersonalScheduleEntities personalScheduleEntities);
  Future<List<PersonalScheduleEntities>> fetchAllPersonalScheduleOfDateLocal(String date);
  Future<Map> fetchPersonalSchoolDataFirebase(String msv);
  Future<List<PersonalScheduleEntities>> fetchAllPersonalScheduleRepoLocal();
  Future<void> deleteAllSchoolPersonalLocal();
  Future<int> deletePersonalScheduleLocal(PersonalScheduleEntities personal);
  Future<int> updatePersonalScheduleDataLocal(
      PersonalScheduleEntities personal);
  Future<List<PersonalScheduleEntities>> listPerSonIsSyncFailed();
  Future<String> syncPersonalSchoolDataFirebase(String msv, Map<String,dynamic> data);
  Future<String> deletePersonalSchoolDataFirebase(String msv, String createAt);
}
