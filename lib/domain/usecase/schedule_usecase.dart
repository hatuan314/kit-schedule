import 'dart:async';

import 'package:schedule/common/constants/timeout_constants.dart';
import 'package:schedule/domain/entities/school_schedule_entities.dart';
import 'package:schedule/domain/repositories/schedule_repositories.dart';

class ScheduleUseCase {
  final ScheduleRepositories scheduleRepositories;

  ScheduleUseCase(this.scheduleRepositories);

  Future<void> insertSchoolScheduleLocal(List<SchoolSchedule> data) async {
    scheduleRepositories.insertSchoolScheduleLocal(data);
  }

  Future<List<SchoolSchedule>> fetchScheduleSchoolOffline() async {
    return scheduleRepositories.fetchScheduleSchoolLocal();
  }

  Future<void> deleteAllSchoolSchedulesLocal() async {
    await scheduleRepositories.deleteAllSchoolSchedulesLocal();
  }

  Future<void> updateAllSchoolSchedulesLocal(List<SchoolSchedule> data) async {
    await scheduleRepositories.updateAllSchoolSchedulesLocal(data);
  }

  Future<Map?> fetchScheduleSchoolData(String account, String password) async {
    try {
      Map? result = await scheduleRepositories
          .fetchScheduleSchoolDataDioRepo(account, password)
          .timeout(TimOutConstants.timeOutConstants);
      if (result == null) {
        return {};
      } else if (result.isNotEmpty) {
        //api có data đồng bộ lên firebase
        await scheduleRepositories.syncScheduleSchoolDataFirebaseRepo(
            account, result);
        return result;
      } else {
        //nếu api trả về trống lấy data trên firebase
        Map result = await scheduleRepositories
            .fetchScheduleSchoolDataFirebaseRepo(account);
        return result;
      }
    } on TimeoutException {
      Map result = await scheduleRepositories
          .fetchScheduleSchoolDataFirebaseRepo(account);
      return result;
    }
  }

  Future<void> deleteAllSchedulesFirebase(String username) async {
    await scheduleRepositories.deleteAllSchedulesFirebase(username);
  }
}
