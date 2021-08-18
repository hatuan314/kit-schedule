import 'dart:async';
import 'dart:developer';

import 'package:schedule/domain/repositories/schedule_repositories.dart';
import 'package:schedule/presentation/journey/main/main_constants.dart';

class ScheduleUseCase {
  final ScheduleRepositories scheduleRepositories;

  ScheduleUseCase(this.scheduleRepositories);
  Future<Map?> fetchScheduleSchoolData(String account, String password) async {
    try {
      Map? result = await scheduleRepositories
          .fetchScheduleSchoolDataDioRepo(account, password)
          .timeout(Duration(seconds: 5));
      if (result == null) {
        return {};
      } else if (result.isNotEmpty) {//api có data đồng bộ lên firebase
        await scheduleRepositories.syncScheduleSchoolDataFirebaseRepo(
            account, result);
        return result;
      } else {//nếu api trả về trống lấy data trên firebase
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
}
