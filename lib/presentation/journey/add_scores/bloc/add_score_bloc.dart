import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/common/enums/view_state.dart';
import 'package:schedule/domain/entities/subject_entities.dart';
import 'package:schedule/domain/usecase/subject_usecase.dart';
import 'package:schedule/models/subject.dart';
import 'package:schedule/service/services.dart';

import 'add_score_event.dart';
import 'add_score_state.dart';

class AddScoreBloc extends Bloc<AddScoreEvent, AddScoreState> {
  final SubjectUsecase subjectUsecase;
  final ShareService _shareService = ShareService();

  AddScoreBloc({required this.subjectUsecase})
      : super(AddScoreState(
            grade: '',
            subject: SubjectEntities(0, '', 0),
            subjectsList: [],
            credits: -1,
            componentScore1: -1,
            componentScore2: -1,
            finalTermScore: -1,
            avgScore: -1,
            viewState: ViewState.idle));

  @override
  Stream<AddScoreState> mapEventToState(AddScoreEvent event) async* {
    if (event is SetUpEvent) {
      yield* _mapSetUpEventToState(event);
    } else if (event is EditGradeEvent) {
      yield* _mapEditGradeEventToState(event);
    } else if (event is EditFinalTermScoreEvent) {
      yield* _mapEditFinalTermScoreEventToState(event);
    } else if (event is EditComponentScore1Event) {
      yield* _mapEditComponentScore1EventToState(event);
    } else if (event is EditComponentScore2Event) {
      yield* _mapEditComponentScore2EventToState(event);
    } else if (event is EditSubjectEvent) {
      yield* _mapEditSubjectEventToState(event);
    }
  }

  Stream<AddScoreState> _mapSetUpEventToState(SetUpEvent event) async* {
    yield state.update(viewState: ViewState.busy);
    String username = await _shareService.getUsername();
    if (username.isNotEmpty) {
      String grade = username.substring(0, 4);
      List<SubjectEntities> list = await subjectUsecase.fetchSubjectDataLocal();

      if (list.isEmpty) {
        final result = await subjectUsecase.fetchSubjectDataFirebaseRepo(grade);
        if (result != null) {
          result.forEach((key, value) {
            list.add(SubjectEntities(
                int.parse(key), value['name'], value['credits']));
          });
        }
        await subjectUsecase.insertSubjectDataLocal(list);
      }
      list.insert(0, SubjectEntities(0, "", 0));

      yield state.update(
          viewState: ViewState.idle,
          subjectsList: list,
          grade: grade,
          subject: list[1]);
    }
  }

  Stream<AddScoreState> _mapEditGradeEventToState(
      EditGradeEvent event) async* {}

  Stream<AddScoreState> _mapEditComponentScore1EventToState(
      EditComponentScore1Event event) async* {}

  Stream<AddScoreState> _mapEditComponentScore2EventToState(
      EditComponentScore2Event event) async* {}

  Stream<AddScoreState> _mapEditFinalTermScoreEventToState(
      EditFinalTermScoreEvent event) async* {}

  Stream<AddScoreState> _mapEditSubjectEventToState(
      EditSubjectEvent event) async* {
    yield state.update(viewState: ViewState.busy);
    if (event.subject.subjectId == 0) {
      //cập nhật ds môn học từ firebase
      List<SubjectEntities> list = [];
      final result =
          await subjectUsecase.fetchSubjectDataFirebaseRepo(state.grade);
      if (result != null) {
        result.forEach((key, value) {
          list.add(
              SubjectEntities(int.parse(key), value['name'], value['credits']));
        });
      }
      await subjectUsecase.insertSubjectDataLocal(list);

      list.insert(0, SubjectEntities(0, "", 0));

      yield state.update(
          viewState: ViewState.idle, subjectsList: list, subject: list[1]);
    } else {
      yield state.update(subject: event.subject);
    }
  }
}
