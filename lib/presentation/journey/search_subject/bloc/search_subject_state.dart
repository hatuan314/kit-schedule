import 'package:equatable/equatable.dart';
import 'package:schedule/common/enums/view_state.dart';
import 'package:schedule/domain/entities/subject_entities.dart';

class SearchSubjectState extends Equatable {
  final List<SubjectEntities> subjectsList;
  final ViewState viewState;

  SearchSubjectState({required this.subjectsList, required this.viewState});

  SearchSubjectState update(
          {List<SubjectEntities>? subjectsList, ViewState? viewState}) =>
      SearchSubjectState(
        viewState: viewState ?? this.viewState,
        subjectsList: subjectsList ?? this.subjectsList,
      );

  @override
  List<Object?> get props => [this.subjectsList, this.viewState];
}
