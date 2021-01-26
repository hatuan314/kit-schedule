
import 'package:schedule/domain/entities/school_entity.dart';

abstract class SchoolScheduleRepository{
  Future<List<SchoolEntity>> fetchAllSchoolSchedule();
  List<SchoolEntity> fetchAllSchoolScheduleOfDate(List<SchoolEntity> schoolScheduleEntity,
      String date);
}