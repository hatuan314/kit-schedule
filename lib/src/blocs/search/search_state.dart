part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  final String selectDay;
  final List<SchoolSchedule> schedulesSchoolOfDay;
  final List<PersonalSchedule> personalSchedulesOfDay;

  SearchState(
      this.selectDay, this.schedulesSchoolOfDay, this.personalSchedulesOfDay);

  @override
  // TODO: implement props
  List<Object> get props =>
      [this.schedulesSchoolOfDay, this.personalSchedulesOfDay];
}

class SearchWaitingState extends SearchState {
  SearchWaitingState(
      String selectDay,
      List<SchoolSchedule> schedulesSchoolOfDay,
      List<PersonalSchedule> personalSchedulesOfDay)
      : super(selectDay, schedulesSchoolOfDay, personalSchedulesOfDay);
}

class SearchLoadingState extends SearchState {
  SearchLoadingState(
      String selectDay,
      List<SchoolSchedule> schedulesSchoolOfDay,
      List<PersonalSchedule> personalSchedulesOfDay)
      : super(selectDay, schedulesSchoolOfDay, personalSchedulesOfDay);
}

class SearchSuccessState extends SearchState {
  SearchSuccessState(
      String selectDay,
      List<SchoolSchedule> schedulesSchoolOfDay,
      List<PersonalSchedule> personalSchedulesOfDay)
      : super(selectDay, schedulesSchoolOfDay, personalSchedulesOfDay);
}

class SearchFailure extends SearchState {
  final String error;

  SearchFailure(
      this.error,
      String selectDay,
      List<SchoolSchedule> schedulesSchoolOfDay,
      List<PersonalSchedule> personalSchedulesOfDay)
      : super(selectDay, schedulesSchoolOfDay, personalSchedulesOfDay);

  @override
  String toString() => 'SearchFailure - Error : {$error}';
}
