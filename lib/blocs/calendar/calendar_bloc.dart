import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/blocs/blocs.dart';
import 'package:schedule/common/utils/convert.dart';
import 'package:schedule/domain/entities/personal_schedule_entities.dart';
import 'package:schedule/domain/entities/school_schedule_entities.dart';
import 'package:schedule/domain/usecase/personal_usecase.dart';
import 'package:schedule/domain/usecase/schedule_usecase.dart';
import 'package:schedule/service/services.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final ScheduleBloc scheduleBloc;
  final PersonalUseCase personalUS;
  final ScheduleUseCase scheduleUS;
  Map<DateTime, List<dynamic>> allSchedulesCalendarMap = Map<DateTime, List>();
  Map<DateTime, List<SchoolSchedule>> allSchoolSchedulesMap =
      Map<DateTime, List<SchoolSchedule>>();
  Map<DateTime, List<PersonalScheduleEntities>> allPersonalSchedulesMap =
      Map<DateTime, List<PersonalScheduleEntities>>();

  CalendarBloc(
      {required this.personalUS,
      required this.scheduleUS,
      required this.scheduleBloc})
      : super(CalendarLoadingDataState());

  @override
  Stream<CalendarState> mapEventToState(CalendarEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetAllScheduleDataEvent) {
      yield CalendarLoadingDataState();
      allSchedulesCalendarMap.clear();
      allSchoolSchedulesMap.clear();
      allPersonalSchedulesMap.clear();
      try {
        // Get All School Schedules Data
        yield* _mapGetAllSchoolSchedulesToMap();
        // Get All Personal Schedules Data
        yield* _mapGetAllPersonalScheduleToMap();
        yield CalendarLoadDataSuccessState(allSchedulesCalendarMap,
            allSchoolSchedulesMap, allPersonalSchedulesMap);
        final scheduleState = scheduleBloc.state;
        if (scheduleState is UpdateScheduleDaySuccessState) {
          scheduleBloc.add(GetScheduleDayEvent(
              selectDay: scheduleState.selectDay,
              allSchedulePersonalMap: allPersonalSchedulesMap,
          allSchedulesSchoolMap: allSchoolSchedulesMap
          ));
        }
      } catch (e) {
        yield CalendarFailureState(e.toString());
      }
    }
  }

  Stream<CalendarState> _mapGetAllSchoolSchedulesToMap() async* {
    if (state is CalendarLoadingDataState) {
      try {
        var result = await scheduleUS.fetchScheduleSchoolOffline();
        debugPrint(
            'CalendarBloc - mapGetAllSchoolScheduleToMap - result: ${result.length}');
        if (result.length > 0) {
          List<SchoolSchedule> allSchoolSchedules = result;
          allSchoolSchedules.forEach((schedule) {
            DateTime scheduleDate = Convert.dateConvert(
                DateTime.fromMillisecondsSinceEpoch(int.parse(schedule.date!)));
            if (allSchedulesCalendarMap[scheduleDate] == null) {
              allSchedulesCalendarMap[scheduleDate] = [];
            }
            if (allSchoolSchedulesMap[scheduleDate] == null) {
              allSchoolSchedulesMap[scheduleDate] = [];
            }
            allSchedulesCalendarMap[scheduleDate]!
                .add(json.encode(schedule.toJson()));
            allSchoolSchedulesMap[scheduleDate]!.add(schedule);
            for (int i = 0;
                i < allSchoolSchedulesMap[scheduleDate]!.length - 1;
                i++) {
              int lesson1 = int.parse(allSchoolSchedulesMap[scheduleDate]![i]
                  .lesson!
                  .split(',')[0]);
              for (int j = i;
                  j < allSchoolSchedulesMap[scheduleDate]!.length;
                  j++) {
                int lesson2 = int.parse(allSchoolSchedulesMap[scheduleDate]![j]
                    .lesson!
                    .split(',')[0]);
                if (lesson1 > lesson2) {
                  SchoolSchedule tmp = allSchoolSchedulesMap[scheduleDate]![i];
                  allSchoolSchedulesMap[scheduleDate]![i] =
                      allSchoolSchedulesMap[scheduleDate]![j];
                  allSchoolSchedulesMap[scheduleDate]![j] = tmp;
                }
              }
            }
          });
        }
      } catch (e) {
        debugPrint('CalendarBloc - mapGetAllSchoolScheduleToMap - error: {$e}');
      }
    }
  }

  Stream<CalendarState> _mapGetAllPersonalScheduleToMap() async* {
    if (state is CalendarLoadingDataState) {
      try {
        // var personalResult = await _offline.fetchAllPersonalScheduleRepo();
        var personalResult =
            await personalUS.fetchAllPersonalScheduleRepoLocal();
        if (personalResult.length > 0) {
          List<PersonalScheduleEntities> allPersonalSchedules = personalResult;
          allPersonalSchedules.forEach((schedule) {
            DateTime scheduleDate = Convert.dateConvert(
                DateTime.fromMillisecondsSinceEpoch(int.parse(schedule.date!)));
            if (allSchedulesCalendarMap[scheduleDate] == null) {
              allSchedulesCalendarMap[scheduleDate] = [];
            }
            if (allPersonalSchedulesMap[scheduleDate] == null) {
              allPersonalSchedulesMap[scheduleDate] = [];
            }
            allSchedulesCalendarMap[scheduleDate]!.add('3');
            allPersonalSchedulesMap[scheduleDate]!.add(schedule);
          });
        }
      } catch (e) {
        debugPrint('CalendarBloc - mapGetAllSchoolScheduleToMap - error: {$e}');
      }
    }
  }
}
