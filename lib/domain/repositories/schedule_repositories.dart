abstract class ScheduleRepositories{
  Future<Map<String,dynamic>?> fetchScheduleSchoolDataDioRepo(String account, String password);
  Future<String> syncScheduleSchoolDataFirebaseRepo(String msv,Map data);
  Future<Map> fetchScheduleSchoolDataFirebaseRepo(String msv);
}