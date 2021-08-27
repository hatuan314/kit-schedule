import 'package:schedule/domain/entities/personal_schedule_entities.dart';
import 'package:schedule/domain/repositories/personal_repositories.dart';

class PersonalUseCase {
  final PersonalRepositories personalRepositories;

  PersonalUseCase({required this.personalRepositories});
  Future<void> insertPersonalSchedule(
      PersonalScheduleEntities personalScheduleEntities) async {
    await personalRepositories
        .insertPersonalScheduleLocal(personalScheduleEntities);
  }

  Future<List<PersonalScheduleEntities>> fetchAllPersonalScheduleOfDate(
      String date) async {
    return personalRepositories.fetchAllPersonalScheduleOfDateLocal(date);
  }

  Future<int> updatePersonalScheduleData(
      PersonalScheduleEntities personal) async {
    return personalRepositories.updatePersonalScheduleDataLocal(personal);
  }

  Future<List<PersonalScheduleEntities>>
      fetchAllPersonalScheduleRepoLocal() async {
    return personalRepositories.fetchAllPersonalScheduleRepoLocal();
  }

  Future<int> deletePersonalScheduleLocal(
      PersonalScheduleEntities personal) async {
    return personalRepositories.deletePersonalScheduleLocal(personal);
  }

  Future<void> deleteAllSchoolPersonal() async {
    await personalRepositories.deleteAllSchoolPersonalLocal();
  }
}
