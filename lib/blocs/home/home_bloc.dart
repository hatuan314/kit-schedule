import 'dart:developer';

import 'package:device_calendar/device_calendar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/blocs/blocs.dart';
import 'package:schedule/common/injector/injector.dart';
import 'package:schedule/common/utils/convert.dart';
import 'package:schedule/domain/entities/personal_schedule_entities.dart';
import 'package:schedule/domain/entities/school_schedule_entities.dart';
import 'package:schedule/domain/usecase/personal_usecase.dart';
import 'package:schedule/domain/usecase/schedule_usecase.dart';
import 'package:schedule/presentation/journey/profile/bloc/profile_bloc.dart';
import 'package:schedule/service/services.dart';

part './home_event.dart';
part './home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ScheduleUseCase scheduleUS;
  final PersonalUseCase personalUS;
  Map<DateTime, List<SchoolSchedule>> allSchoolSchedulesMap =
  Map<DateTime, List<SchoolSchedule>>();
  Map<DateTime, List<PersonalScheduleEntities>> allPersonalSchedulesMap =
  Map<DateTime, List<PersonalScheduleEntities>>();
  DeviceCalendarPlugin _deviceCalendarPlugin=DeviceCalendarPlugin();
  List<Calendar> _calendars=[];
  HomeBloc({required this.personalUS, required this.scheduleUS})
      : super(HomeInitialState(0));
  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is OnTabChangeEvent) {
      // await _retrieveCalendars();
      // _calendars.forEach((element) {
      //   debugPrint(element.id+'  '+element.name);
      // });
      bool isSynch = true;
      if (event.selectIndex == 4) {
        var result = await personalUS.listPerSonIsSyncFailed();
        isSynch = result.isEmpty;
      }
      yield HomeOnChangeTabState(event.selectIndex, isSynch);
    } else if (event is SignOutOnPressEvent) {
      ShareService shareService = ShareService();
      try {
        bool hasNoti= await shareService.getHasNoti() as bool;
        if(hasNoti)
          {
            yield* _mapGetAllSchoolSchedulesToMap();
            yield* _mapGetAllPersonalScheduleToMap();
            await _retrieveCalendars();
            allSchoolSchedulesMap.forEach((key, value) {
              _deleteSchoolSchedule(value, key.millisecondsSinceEpoch);
            });
            allPersonalSchedulesMap.forEach((key, value) {
              _deletePersonalSchedule(value, key.millisecondsSinceEpoch);
            });
            await shareService.setHasNoti(false);
          }


        await scheduleUS.deleteAllSchoolSchedulesLocal();
        await personalUS.deleteAllSchoolPersonal();
        await shareService.setUsername('');
        await shareService.setIsSaveData(false);

        Injector.getIt.resetLazySingleton<CalendarBloc>();
        Injector.getIt.resetLazySingleton<ScheduleBloc>();
        Injector.getIt.resetLazySingleton<ProfileBloc>();
        yield SignOutSuccessState(0);
      } catch (e) {
        debugPrint('HomeBloc - mapEventToState - Error: {$e}');
        yield SignOutFailureState(0);
      }
    }
  }

  _retrieveCalendars() async {
    try {
      var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
      if (permissionsGranted.isSuccess && !permissionsGranted.data) {
        permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
        if (!permissionsGranted.isSuccess || !permissionsGranted.data) {
          return;
        }
      }
      final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();

      _calendars = calendarsResult.data as List<Calendar>;

    } catch (e) {
      print(e);
    }
  }

  Future _deleteSchoolSchedule(
      List<SchoolSchedule> schoolList, int date) async {
    for (var schoolSchedule in schoolList) {
      List lessonNumbers = schoolSchedule.lesson!.split(',');
      int startLessonHour = int.parse(
          Convert.startTimeLessonMap[lessonNumbers[0]]!.split(':')[0]);
      int startLessonMinute = int.parse(
          Convert.startTimeLessonMap[lessonNumbers[0]]!.split(':')[1]);
      final int eventTime = date - (7 * 3600000);
      String eventId = DateTime.fromMillisecondsSinceEpoch(
          eventTime + startLessonHour * 3600000 + startLessonMinute * 60000)
          .toString();
      final deleteResult =
      await _deviceCalendarPlugin.deleteEvent(4.toString(), eventId);
      debugPrint('delete school '+deleteResult.isSuccess.toString());
    }
  }

  Future _deletePersonalSchedule(
      List<PersonalScheduleEntities> personalList, int date) async {
    for (var personalSchedule in personalList) {
      final deleteResult = await _deviceCalendarPlugin.deleteEvent(
          4.toString(), personalSchedule.createAt);
      debugPrint('delete personal '+deleteResult.isSuccess.toString());
      // }
    }
  }

  Stream<HomeState> _mapGetAllSchoolSchedulesToMap() async* {
    try {
      var result = await scheduleUS.fetchScheduleSchoolOffline();
      debugPrint(
          'CalendarBloc - mapGetAllSchoolScheduleToMap - result: ${result.length}');
      if (result.length > 0) {
        List<SchoolSchedule> allSchoolSchedules = result;
        allSchoolSchedules.forEach((schedule) {
          DateTime scheduleDate = Convert.dateConvert(
              DateTime.fromMillisecondsSinceEpoch(int.parse(schedule.date!)));

          if (allSchoolSchedulesMap[scheduleDate] == null) {
            allSchoolSchedulesMap[scheduleDate] = [];
          }
          allSchoolSchedulesMap[scheduleDate]!.add(schedule);
        });
      }
    } catch (e) {
      debugPrint('CalendarBloc - mapGetAllSchoolScheduleToMap - error: {$e}');
    }
  }

  Stream<HomeState> _mapGetAllPersonalScheduleToMap() async* {
    try {
      var personalResult = await personalUS.fetchAllPersonalScheduleRepoLocal();
      if (personalResult.length > 0) {
        List<PersonalScheduleEntities> allPersonalSchedules = personalResult;
        allPersonalSchedules.forEach((schedule) {
          DateTime scheduleDate = Convert.dateConvert(
              DateTime.fromMillisecondsSinceEpoch(int.parse(schedule.date!)));

          if (allPersonalSchedulesMap[scheduleDate] == null) {
            allPersonalSchedulesMap[scheduleDate] = [];
          }
          allPersonalSchedulesMap[scheduleDate]!.add(schedule);
        });
      }
    } catch (e) {
      debugPrint('CalendarBloc - mapGetAllSchoolScheduleToMap - error: {$e}');
    }
  }

}
