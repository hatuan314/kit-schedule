import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/common/enums/view_state.dart';
import 'package:schedule/domain/entities/subject_entities.dart';
import 'package:schedule/domain/usecase/scores_usecase.dart';
import 'package:schedule/domain/usecase/subject_usecase.dart';
import 'package:schedule/presentation/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:schedule/presentation/journey/search_subject/bloc/search_subject_event.dart';
import 'package:schedule/presentation/journey/search_subject/bloc/search_subject_state.dart';
import 'package:schedule/service/services.dart';

class SearchSubjectBloc extends Bloc<SearchSubjectEvent, SearchSubjectState> {
  final SubjectUsecase subjectUsecase;
  final ShareService _shareService = ShareService();

  SearchSubjectBloc({
    required this.subjectUsecase,
  }) : super(SearchSubjectState(subjectsList: [], viewState: ViewState.idle));

  @override
  Stream<SearchSubjectState> mapEventToState(SearchSubjectEvent event) async* {
    if (event is GetSubjectListEvent) {
      yield* _mapGetSubjectListEventToState(event);
    } else if (event is UpdateSubjectFromFirebaseEvent) {
      yield* _mapUpdateSubjectFromFirebaseEventToState(event);
    } else if (event is SearchEvent) {
      yield* _mapSearchSubjectEventToState(event);
    }
  }

  Stream<SearchSubjectState> _mapGetSubjectListEventToState(
      GetSubjectListEvent event) async* {
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
      );
    }
  }

  Stream<SearchSubjectState> _mapSearchSubjectEventToState(
      SearchEvent event) async* {
    yield state.update(viewState: ViewState.searching);
    final result = await subjectUsecase.searchSubjectDataLocal(event.keyword);

    yield state.update(viewState: ViewState.idle, subjectsList: result);
  }

  Stream<SearchSubjectState> _mapUpdateSubjectFromFirebaseEventToState(
      UpdateSubjectFromFirebaseEvent event) async* {
    yield state.update(viewState: ViewState.busy);
    //cập nhật ds môn học từ firebase
    List<SubjectEntities> list = [];
    final result =
        await subjectUsecase.fetchSubjectDataFirebaseRepo(event.grade);
    if (result.isNotEmpty) {
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

    yield state.update(
      viewState: ViewState.idle,
      subjectsList: list,
    );
  }
}
