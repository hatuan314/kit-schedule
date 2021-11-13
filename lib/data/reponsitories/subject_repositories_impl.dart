import 'package:schedule/data/local_data_source/subject_hive.dart';
import 'package:schedule/data/remote/data_remote.dart';
import 'package:schedule/domain/entities/subject_entities.dart';
import 'package:schedule/domain/repositories/schedule_repositories.dart';
import 'package:schedule/domain/repositories/subject_repositories.dart';

class SubjectRepositoriesImpl extends SubjectRepositories{
  final DataRemote dataRemote;
  final SubjectHive subjectHive;

  SubjectRepositoriesImpl(this.dataRemote, this.subjectHive);


  @override
  Future<Map> fetchSubjectDataFirebaseRepo(String grade) async {
    return await dataRemote.fetchSubjectDataFirebase(grade);
  }

  @override
  Future<List<SubjectEntities>> fetchSubjectDataLocal() async {
    return await subjectHive.fetchAllSubjects();
  }

  @override
  Future insertSubjectDataLocal(List<SubjectEntities> subjectsList) async {
    await subjectHive.insertSubjectsList(subjectsList);
  }

  @override
  Future<List<SubjectEntities>> searchSubjectDataLocal(String subject)async {
    return subjectHive.searchSubject(subject);
  }

}