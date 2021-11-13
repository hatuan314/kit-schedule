import 'package:schedule/domain/entities/subject_entities.dart';

abstract class SubjectRepositories{

  Future<Map> fetchSubjectDataFirebaseRepo(String grade);

  Future insertSubjectDataLocal(List<SubjectEntities> subjectsList);

  Future <List<SubjectEntities>> fetchSubjectDataLocal();

  Future<List<SubjectEntities>> searchSubjectDataLocal(String subject);
}