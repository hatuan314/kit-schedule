import 'package:schedule/data/remote/data_remote.dart';
import 'package:schedule/domain/repositories/schedule_repositories.dart';

class ScheduleRepositoriesImpl extends ScheduleRepositories {
  final DataRemote dataRemote;

  ScheduleRepositoriesImpl(this.dataRemote);

  @override
  Future<Map<String, dynamic>?> fetchScheduleSchoolDataDioRepo(
      String account, String password) {
    return dataRemote.fetchScheduleSchoolDataDio(account, password);
  }

  @override
  Future<Map> fetchScheduleSchoolDataFirebaseRepo(String msv) {
    return dataRemote.fetchScheduleSchoolDataFirebase(msv);
  }

  @override
  Future<String> syncScheduleSchoolDataFirebaseRepo(String msv,Map data) {
    return dataRemote.syncScheduleSchoolDataFirebase(msv,data);
  }
}
