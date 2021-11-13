import 'package:schedule/domain/entities/subject_entities.dart';
import 'package:schedule/domain/repositories/subject_repositories.dart';

class SubjectUsecase{
  final SubjectRepositories subjectRepositories;

  SubjectUsecase(this.subjectRepositories);

  Future<Map> fetchSubjectDataFirebaseRepo(String grade) async {
    return await subjectRepositories.fetchSubjectDataFirebaseRepo(grade);
  }

  Future<List<SubjectEntities>> fetchSubjectDataLocal() async {
    return await subjectRepositories.fetchSubjectDataLocal();
  }

  Future<List<SubjectEntities>> searchSubjectDataLocal(String subject) async {
    return await subjectRepositories.searchSubjectDataLocal(subject);
  }

  Future insertSubjectDataLocal(List<SubjectEntities> subjectsList) async {
    await subjectRepositories.insertSubjectDataLocal(subjectsList);
  }
}