import 'package:schedule/data/local_data_source/personal_hive.dart';
import 'package:schedule/domain/entities/personal_schedule_entities.dart';
import 'package:schedule/domain/repositories/personal_repositories.dart';

class PersonalRepositoriesImpl extends PersonalRepositories {
  final PersonalHive personalHive;

  PersonalRepositoriesImpl(this.personalHive);
  @override
  Future<List<PersonalScheduleEntities>> fetchAllPersonalScheduleOfDateLocal(
      String date) async {
    return personalHive.fetchAllPersonalScheduleOfDate(date);
  }
  Future<void> deleteAllSchoolPersonalLocal()async{
    await personalHive.deleteAllSchoolPersonal();
  }
  Future<int> deletePersonalScheduleLocal(PersonalScheduleEntities personal)async{
    return personalHive.deletePersonalSchedule(personal);
  }
  @override
  Future<List<PersonalScheduleEntities>> fetchAllPersonalScheduleRepoLocal() {
    return personalHive.fetchAllPersonalScheduleRepoLocal();
  }

  @override
  Future<void> insertPersonalScheduleLocal(
      PersonalScheduleEntities personalScheduleEntities) async {
    await personalHive.insertPersonalSchedule(personalScheduleEntities);
  }

  @override
  Future<int> updatePersonalScheduleDataLocal(PersonalScheduleEntities personal) async{
    return personalHive.updatePersonalScheduleData(personal);
  }
}
