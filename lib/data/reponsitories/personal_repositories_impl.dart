import 'package:schedule/data/local_data_source/personal_hive.dart';
import 'package:schedule/data/remote/data_remote.dart';
import 'package:schedule/domain/entities/personal_schedule_entities.dart';
import 'package:schedule/domain/repositories/personal_repositories.dart';

class PersonalRepositoriesImpl extends PersonalRepositories {
  final PersonalHive personalHive;
  final DataRemote dataRemote;

  PersonalRepositoriesImpl(this.personalHive, this.dataRemote);

  @override
  Future<List<PersonalScheduleEntities>> fetchAllPersonalScheduleOfDateLocal(
      String date) async {
    return personalHive.fetchAllPersonalScheduleOfDate(date);
  }

  Future<void> deleteAllSchoolPersonalLocal() async {
    await personalHive.deleteAllSchoolPersonal();
  }

  Future<int> deletePersonalScheduleLocal(
      PersonalScheduleEntities personal) async {
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
  Future<int> updatePersonalScheduleDataLocal(
      PersonalScheduleEntities personal) async {
    return personalHive.updatePersonalScheduleData(personal);
  }

  @override
  Future<List<PersonalScheduleEntities>> listPerSonIsSyncFailed() {
    return personalHive.listPerSonIsSyncFailed();
  }

  @override
  Future<String> syncPersonalSchoolDataFirebase(
      String msv, Map<String, dynamic> data) {
    return dataRemote.syncPersonalSchoolDataFirebase(msv, data);
  }

  @override
  Future<Map> fetchPersonalSchoolDataFirebase(String msv) {
    return dataRemote.fetchPersonalSchoolDataFirebase(msv);
  }

  @override
  Future<String> deletePersonalSchoolDataFirebase(String msv, String createAt) {
    return dataRemote.deletePersonalSchoolDataFirebase(msv, createAt);
  }

  @override
  Future<void> deleteAllPersonalFirebase(String username) {
    return dataRemote.deleteAllPersonalFirebase(username);
  }
}
