import 'package:equatable/equatable.dart';

abstract class SearchSubjectEvent extends Equatable {}

class GetSubjectListEvent extends SearchSubjectEvent {
  final String grade;
  GetSubjectListEvent(this.grade);

  @override
  // TODO: implement props
  List<Object?> get props => [grade];
}

class SearchEvent extends SearchSubjectEvent {
  final String keyword;

  SearchEvent({required this.keyword});
  @override
  List<Object?> get props => [this.keyword];
}

class UpdateSubjectFromFirebaseEvent extends SearchSubjectEvent {
  final String grade;

  UpdateSubjectFromFirebaseEvent(this.grade);

  @override
  // TODO: implement props
  List<Object?> get props => [grade];
}
