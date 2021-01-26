import 'package:schedule/domain/entities/personal_schedule.dart';

abstract class PersonalScheduleRepository {

  Future<List<PersonalScheduleEntity>> fetchAllPersonalSchedule();

  Future<List<PersonalScheduleEntity>> fetchAllPersonalScheduleOfDate(
      String date);

  Future addPersonalSchedule(PersonalScheduleEntity schedule);

  Future<int> updatePersonalScheduleData(PersonalScheduleEntity schedule);

  Future<int> deletePersonalSchedule(String id);
}