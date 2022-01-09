import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/common/enums/view_state.dart';
import 'package:schedule/common/utils/convert.dart';
import 'package:schedule/domain/entities/score_entities.dart';
import 'package:schedule/domain/entities/subject_entities.dart';
import 'package:schedule/domain/usecase/scores_usecase.dart';
import 'package:schedule/domain/usecase/subject_usecase.dart';
import 'package:schedule/presentation/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:schedule/presentation/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:schedule/presentation/bloc/snackbar_bloc/snackbar_type.dart';
import 'package:schedule/service/services.dart';

import 'add_score_event.dart';
import 'add_score_state.dart';

class AddScoreBloc extends Bloc<AddScoreEvent, AddScoreState> {
  final SubjectUsecase subjectUsecase;
  final ScoresUsecase scoresUsecase;
  final ShareService _shareService = ShareService();
  SnackbarBloc snackbarBloc;

  AddScoreBloc(
      {required this.subjectUsecase,
      required this.scoresUsecase,
      required this.snackbarBloc})
      : super(AddScoreState(
            grade: '',
            subject: SubjectEntities(
              subjectId: 0,
              subjectName: '',
              credits: 0,
            ),
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
    } else if (event is EditSubjectEvent) {
      yield* _mapEditSubjectEventToState(event);
    } else if (event is CalculateScoreEvent) {
      yield* _mapCalculateScoreEventToState(event);
    } else if (event is SaveNewScoreEvent) {
      yield* _mapSaveNewScoreEventToState(event);
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
              ),
            );
          });
        }
        await subjectUsecase.insertSubjectDataLocal(list);
      }

      yield state.update(
        viewState: ViewState.idle,
        subjectsList: list,
        grade: grade,
      );
    }
  }

  Stream<AddScoreState> _mapCalculateScoreEventToState(
      CalculateScoreEvent event) async* {
    double avgScore = 0;
    if (event.componentScore2 >= 4 &&
        event.componentScore1 >= 4 &&
        event.finalTermScore >= 4) {
      avgScore =
          ((event.componentScore1 * 0.7 + event.componentScore2 * 0.3) * 0.3 +
              event.finalTermScore * 0.7);
    }
    yield state.update(avgScore: double.parse((avgScore.toStringAsFixed(1))));
  }

  Stream<AddScoreState> _mapSaveNewScoreEventToState(
      SaveNewScoreEvent event) async* {
    if (state.subject.subjectName != '' && state.avgScore >= 0) {
      log(state.subject.subjectName.toString());
      ScoreEntities newScore = ScoreEntities(
          id: state.subject.subjectId,
          subject: state.subject.subjectName,
          credits: state.subject.credits,
          scoreIn10: state.avgScore,
          scoreIn4:
              Convert.letterScoreConvert[Convert.scoreConvert(state.avgScore)],
          letter: Convert.scoreConvert(state.avgScore));
      try {
        scoresUsecase.insertScore(newScore);
        snackbarBloc.add(ShowSnackbar(
            title: '${SnackBarTitle.CreateSuccess}',
            type: SnackBarType.success));
        yield state.update(viewState: ViewState.success);
      } catch (e) {
        snackbarBloc.add(ShowSnackbar(
            title: '${SnackBarTitle.CreateFailed}', type: SnackBarType.error));
        yield state.update(viewState: ViewState.idle);
      }
    }
  }

  Stream<AddScoreState> _mapEditSubjectEventToState(
      EditSubjectEvent event) async* {
    yield state.update(subject: event.subject);
  }
}
