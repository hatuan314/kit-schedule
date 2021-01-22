import 'package:schedule/domain/entities/personal_schedule.dart';

abstract class PersonalScheduleRepository {

  Future<List<PersonalSchedule>> fetchAllPersonalSchedule();

  Future<List<PersonalSchedule>> fetchAllPersonalScheduleOfDate(
      String date);

  Future addPersonalSchedule(PersonalSchedule schedule);

  Future<int> updatePersonalScheduleData(PersonalSchedule schedule);

  Future<int> deletePersonalSchedule(String id);
}