import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/common/enums/view_state.dart';
import 'package:schedule/domain/entities/subject_entities.dart';
import 'package:schedule/domain/usecase/subject_usecase.dart';
import 'package:schedule/service/services.dart';

import 'add_score_event.dart';
import 'add_score_state.dart';

class AddScoreBloc extends Bloc<AddScoreEvent, AddScoreState> {
  final SubjectUsecase subjectUsecase;
  final ShareService _shareService = ShareService();

  AddScoreBloc({required this.subjectUsecase})
      : super(AddScoreState(
            grade: '',
            subject: SubjectEntities(
                subjectId: 0, subjectName: '', credits: 0, isAdded: false),
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
      // } else if (event is EditGradeEvent) {
      //   yield* _mapEditGradeEventToState(event);
      // } else if (event is EditFinalTermScoreEvent) {
      //   yield* _mapEditFinalTermScoreEventToState(event);
    } else if (event is UpdateSubjectFromFirebaseEvent) {
      yield* _mapUpdateSubjectFromFirebaseEventToState(event);
    } else if (event is SearchSubjectEvent) {
      yield* _mapSearchSubjectEventToState(event);
    } else if (event is EditSubjectEvent) {
      yield* _mapEditSubjectEventToState(event);
    } else if (event is CalculateScoreEvent) {
      yield* _mapCalculateScoreEventToState(event);
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
            list.add(
              SubjectEntities(
                  subjectId: int.parse(key),
                  subjectName: value['name'],
                  credits: value['credits'],
                  isAdded: false),
            );
          });
        }
        await subjectUsecase.insertSubjectDataLocal(list);
      }

      yield state.update(
          viewState: ViewState.idle,
          subjectsList: list,
          grade: grade,
          subject: list[1]);
    }
  }

  Stream<AddScoreState> _mapCalculateScoreEventToState(
      CalculateScoreEvent event) async* {
    double avgScore =
        ((event.componentScore1 * 0.7 + event.componentScore2 * 0.3) * 0.3 +
            event.finalTermScore * 0.7);
    yield state.update(avgScore: double.parse((avgScore.toStringAsFixed(1))));
  }

  Stream<AddScoreState> _mapSearchSubjectEventToState(
      SearchSubjectEvent event) async* {
    yield state.update(viewState: ViewState.searching);
    final result = await subjectUsecase.searchSubjectDataLocal(event.keyword);

    yield state.update(viewState: ViewState.idle, subjectsList: result);
  }

  // Stream<AddScoreState> _mapEditComponentScore1EventToState(
  //     EditComponentScore1Event event) async* {}
  //
  // Stream<AddScoreState> _mapEditComponentScore2EventToState(
  //     EditComponentScore2Event event) async* {}
  //
  Stream<AddScoreState> _mapUpdateSubjectFromFirebaseEventToState(
      UpdateSubjectFromFirebaseEvent event) async* {
    yield state.update(viewState: ViewState.busy);
    //cập nhật ds môn học từ firebase
    List<SubjectEntities> list = [];
    final result =
        await subjectUsecase.fetchSubjectDataFirebaseRepo(state.grade);
    if (result.isNotEmpty) {
      result.forEach((key, value) {
        list.add(
          SubjectEntities(
              subjectId: int.parse(key),
              subjectName: value['name'],
              credits: value['credits'],
              isAdded: false),
        );
      });
    }
    await subjectUsecase.insertSubjectDataLocal(list);

    yield state.update(
        viewState: ViewState.idle, subjectsList: list, subject: list[1]);
  }

  Stream<AddScoreState> _mapEditSubjectEventToState(
      EditSubjectEvent event) async* {
    yield state.update(subject: event.subject);
  }
}
