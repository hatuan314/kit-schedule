part of 'schedule_bloc.dart';

abstract class ScheduleState extends Equatable {}

class UpdateScheduleDayInitState extends ScheduleState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UpdateScheduleDayLoadingState extends ScheduleState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UpdateScheduleDaySuccessState extends ScheduleState {
  final List<SchoolSchedule>? schedulesSchoolOfDay;
  final List<PersonalScheduleEntities>? schedulesPersonalOfDay;

  UpdateScheduleDaySuccessState(
      this.schedulesSchoolOfDay, this.schedulesPersonalOfDay);

  @override
  // TODO: implement props
  List<Object?> get props =>
      [this.schedulesSchoolOfDay, this.schedulesPersonalOfDay];
}

class UpdateScheduleDayFailureState extends ScheduleState {
  final String error;

  UpdateScheduleDayFailureState(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [this.error];

  @override
  String toString() => 'UpdateScheduleSchoolDayFailureState - error: {$error}';
}
