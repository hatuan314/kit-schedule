part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetScheduleDayEvent extends ScheduleEvent {
  final DateTime? selectDay;
  final Map<DateTime, List<SchoolSchedule>>? allSchedulesSchoolMap;
  final Map<DateTime, List<PersonalScheduleEntities>>? allSchedulePersonalMap;

  GetScheduleDayEvent(
      {this.selectDay,
      this.allSchedulesSchoolMap,
      this.allSchedulePersonalMap});

  @override
  // TODO: implement props
  List<Object?> get props => [this.selectDay];
}
