import 'dart:async';
import 'dart:developer';

import 'package:connectivity/connectivity.dart';
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

  Future<List<PersonalScheduleEntities>> fetchPersonalSchoolDataFirebase(
      String msv) async {
    final result =
        await personalRepositories.fetchPersonalSchoolDataFirebase(msv);
    List<PersonalScheduleEntities> data = [];
    if (result.isNotEmpty) {
      result.forEach((key, value) {
        if (value['updateAt'] != '0') {
          data.add(PersonalScheduleEntities.fromJson(value, key));
        }
      });
    }
    return data;
  }

  Future<List<PersonalScheduleEntities>> fetchAllPersonalScheduleOfDate(
      String date) async {
    return personalRepositories.fetchAllPersonalScheduleOfDateLocal(date);
  }

  Future<int> updatePersonalScheduleData(
      PersonalScheduleEntities personal) async {
    return personalRepositories.updatePersonalScheduleDataLocal(personal);
  }

  Future<String> syncPersonalSchoolDataFirebase(String msv,
      [PersonalScheduleEntities? personal]) async {
    Map<String, Map> data = <String, Map>{};
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return '';
    } else {
      if (personal == null) {
        List<PersonalScheduleEntities> listPersonal =
            await personalRepositories.listPerSonIsSyncFailed();
        listPersonal.forEach((element) {
          data.addAll({'${element.createAt}': element.toJson()});
        });
      } else {
        data.addAll({'${personal.createAt}': personal.toJson()});
      }
      final result = personalRepositories
          .syncPersonalSchoolDataFirebase(msv, data)
          .timeout(Duration(seconds: 2))
          .onError((error, stackTrace) => '');
      return result;
    }
  }

  Future<List<PersonalScheduleEntities>> listPerSonIsSyncFailed() async {
    return personalRepositories.listPerSonIsSyncFailed();
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
