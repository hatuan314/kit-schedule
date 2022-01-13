import 'package:schedule/common/config/local_config.dart';
import 'package:schedule/domain/entities/subject_entities.dart';

class SubjectHive{
  final LocalConfig hiveConfig;

  SubjectHive( {required this.hiveConfig});

  Future<void> insertSubjectsList(List<SubjectEntities> subjectEntities) async
  {
    await hiveConfig.subjectBox.clear();
    await hiveConfig.subjectBox.addAll(subjectEntities);
  }

  Future<List<SubjectEntities>> fetchAllSubjects() async
  {
    return await hiveConfig.subjectBox.values.toList();
  }

  Future<List<SubjectEntities>> searchSubject(String subject) async
  {
    return await hiveConfig.subjectBox.values.where((element) => element.subjectName!.contains(subject)).toList();
  }
}