import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/domain/entities/personal_schedule.dart';
import 'package:schedule/domain/entities/school_entity.dart';
import 'package:schedule/domain/use_cases/schedule_use_case.dart';

import 'package:schedule/presentation/screen/home_screen/calendarView/bloc/calendar_event.dart';
import 'package:schedule/presentation/screen/home_screen/calendarView/bloc/calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent,CalendarState>{
  final ScheduleUseCase scheduleUseCase;
  List<SchoolEntity> listSchoolEntity;
  Map<DateTime, List> _allSchedule;

  CalendarBloc({@required this.scheduleUseCase});

  @override
  CalendarState get initialState => CalendarLoadingState();

  @override
  Stream<CalendarState> mapEventToState(CalendarEvent event) async* {
    if (event is CalendarInitEvent){
      yield* _mapCalendarInitEventToState();
    }else if (event is CalendarSelectDayEvent){
      yield* _mapCalendarSelectDayEventToState(event);
    }
  }

  Stream<CalendarState>_mapCalendarInitEventToState() async*{
    yield CalendarLoadingState();
    listSchoolEntity = await scheduleUseCase.initData();
    _allSchedule = scheduleUseCase.mapAllListEntityToMap(listSchoolEntity);
    yield CalendarInitState(allSchedule: _allSchedule);
  }

  Stream<CalendarState>_mapCalendarScheduleEventToState() async* {
    yield CalendarLoadingState();
    //yield CalendarSuccessState();
  }

  Stream<CalendarState> _mapCalendarSelectDayEventToState(CalendarSelectDayEvent event) async*{
    yield CalendarLoadingState();
    List<SchoolEntity> output = await scheduleUseCase.getScheduleFromDate(_allSchedule, event.selectedDay);
    yield CalendarInitState(allSchedule: _allSchedule,listScheduleOfDay: output);
  }

}