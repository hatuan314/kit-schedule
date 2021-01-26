import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:schedule/domain/entities/personal_schedule.dart';
import 'package:schedule/domain/entities/school_entity.dart';

abstract class CalendarState extends Equatable {
  final Map<DateTime, List> allSchedule;

  CalendarState({this.allSchedule});

}
class CalendarLoadingState extends CalendarState {
  @override
  List<Object> get props => [];
}
class CalendarInitState extends CalendarState {
  final Map<DateTime, List> allSchedule;
  final List<SchoolEntity> listScheduleOfDay;

  CalendarInitState({this.allSchedule, this.listScheduleOfDay});

  @override
  List<Object> get props => [];
}
class CalendarSelectedDayState extends CalendarState {
  final List<SchoolEntity> listAllSchedule;
  CalendarSelectedDayState({this.listAllSchedule});

  @override
  List<Object> get props => [listAllSchedule];
}

class CalendarSuccessState extends CalendarState {
  final Map<DateTime, List> allSchedule;

  CalendarSuccessState({this.allSchedule});

  @override
  List<Object> get props => [];

}