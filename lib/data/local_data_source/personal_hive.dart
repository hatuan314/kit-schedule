import 'dart:developer';

import 'package:schedule/common/config/local_config.dart';
import 'package:schedule/domain/entities/personal_schedule_entities.dart';

class PersonalHive {
  final LocalConfig hiveConfig;

  PersonalHive({required this.hiveConfig});
  Future<void> insertPersonalSchedule(
      PersonalScheduleEntities personalScheduleEntities) async {
    log('${personalScheduleEntities.createAt}');
    await hiveConfig.personalBox.add(personalScheduleEntities);
  }

  Future<List<PersonalScheduleEntities>>
      fetchAllPersonalScheduleRepoLocal() async {
    List<PersonalScheduleEntities> result =
        hiveConfig.personalBox.values.toList();
    result.sort((a, b) => a.date!.compareTo(b.date!));
    return result;
  }

  Future<List<PersonalScheduleEntities>> fetchAllPersonalScheduleOfDate(
      String date) async {
    final result = hiveConfig.personalBox.values
        .where((element) => element.date == date)
        .toList();
    result.sort((a, b) => int.parse(a.date!).compareTo(int.parse(b.date!)));
    return result;
  }

  Future<int> updatePersonalScheduleData(
      PersonalScheduleEntities personal) async {
    log('${personal.createAt}');
    final result = hiveConfig.personalBox.values;
    for (int i = 0; i < result.length; i++) {
      if (result.elementAt(i).createAt == personal.createAt) {
       await hiveConfig.personalBox.putAt(
            i,
            PersonalScheduleEntities(
                date: personal.date,
                name: personal.name,
                timer: personal.timer,
                note: personal.note,
                createAt: personal.createAt,
                updateAt: personal.updateAt));
        return 1;
      }
    }
    return 0;
  }

  Future<int> deletePersonalSchedule(PersonalScheduleEntities personal) async {
    var result = hiveConfig.personalBox.values;
    try {
      for (int i = 0; i < result.length; i++) {
        if (result.elementAt(i) == personal) {
          hiveConfig.personalBox.deleteAt(i);
          return 1;
        }
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }

  Future<void> deleteAllSchoolPersonal() async {
    await hiveConfig.personalBox.clear();
  }
}
