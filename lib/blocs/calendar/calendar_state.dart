part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {}

class CalendarLoadingDataState extends CalendarState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CalendarLoadDataSuccessState extends CalendarState {
  final Map<DateTime, List> allSchedulesCalendarMap;
  final Map<DateTime, List<SchoolSchedule>> allSchedulesSchoolMap;
  final Map<DateTime, List<PersonalScheduleEntities>> allSchedulePersonalMap;

  CalendarLoadDataSuccessState(this.allSchedulesCalendarMap,
      this.allSchedulesSchoolMap, this.allSchedulePersonalMap);

  @override
  // TODO: implement props
  List<Object> get props => [this.allSchedulesCalendarMap];
}

class CalendarNoDataState extends CalendarState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CalendarFailureState extends CalendarState {
  final String error;

  CalendarFailureState(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [this.error];

  @override
  String toString() => "HomeFailureState - error: {$error}";
}
