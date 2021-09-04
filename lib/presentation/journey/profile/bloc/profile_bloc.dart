import 'dart:convert';

import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/common/utils/convert.dart';
import 'package:schedule/domain/entities/personal_schedule_entities.dart';
import 'package:schedule/domain/entities/school_schedule_entities.dart';
import 'package:schedule/domain/usecase/personal_usecase.dart';
import 'package:schedule/domain/usecase/schedule_usecase.dart';
import 'package:schedule/presentation/journey/profile/bloc/profile_event.dart';
import 'package:schedule/presentation/journey/profile/bloc/profile_state.dart';
import 'package:schedule/service/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final PersonalUseCase personalUS;
  final ScheduleUseCase scheduleUS;
  Map<DateTime, List<SchoolSchedule>> allSchoolSchedulesMap =
      Map<DateTime, List<SchoolSchedule>>();
  Map<DateTime, List<PersonalScheduleEntities>> allPersonalSchedulesMap =
      Map<DateTime, List<PersonalScheduleEntities>>();

  DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();
  ShareService _shareService = ShareService();
  List<Calendar> _calendars = [];

  ProfileBloc({
    required this.personalUS,
    required this.scheduleUS,
  }) : super(ProfileState(username: '', hasNoti: false));

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is GetUserNameInProfileEvent)
      yield state.update(
          username: (await ShareService().getUsername() as String),
          hasNoti: (await ShareService().getHasNoti() as bool));

    if (event is TurnOnNotificationEvent)
      yield* _mapTurnOnNotificationEventToState(event);
    if (event is TurnOffNotificationEvent)
      yield* _mapTurnOffNotificationEventToState(event);
  }

  Stream<ProfileState> _mapTurnOnNotificationEventToState(
      TurnOnNotificationEvent event) async* {
    yield* _mapGetAllSchoolSchedulesToMap();
    yield* _mapGetAllPersonalScheduleToMap();
    await _retrieveCalendars();
    await scheduleUS.deleteAllSchoolSchedulesLocal();
  //  await personalUS.deleteAllSchoolPersonal();

//    allSchoolSchedulesMap.forEach((key, value) {
  //    _addSchoolScheduleToCalendar(value, key.millisecondsSinceEpoch);
    //});
    await _addSchoolScheduleToCalendar();
    await   _addPersonalScheduleToCalendar();

       allSchoolSchedulesMap.forEach((key, value) async {
      await scheduleUS.insertSchoolScheduleLocal(value);
    });

       allPersonalSchedulesMap.forEach((key, value) async{
         for(var x in value)
           {
             await personalUS.updatePersonalScheduleData(x);
           }
       });


    await _shareService.setHasNoti(true);
  }

  Stream<ProfileState> _mapTurnOffNotificationEventToState(
      TurnOffNotificationEvent event) async* {
    yield* _mapGetAllSchoolSchedulesToMap();
    yield* _mapGetAllPersonalScheduleToMap();
    await _retrieveCalendars();

    await  _deleteSchoolSchedule( );

    await  _deletePersonalSchedule( );
    await _shareService.setHasNoti(false);
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

  Future _addSchoolScheduleToCalendar() async {
       allSchoolSchedulesMap.forEach((key, value) async{
        for(var schoolSchedule in value)
          {
              List lessonNumbers = schoolSchedule.lesson!.split(',');

              int startLessonHour = int.parse(
                  Convert.startTimeLessonMap[lessonNumbers[0]]!.split(':')[0]);
              int startLessonMinute = int.parse(
                  Convert.startTimeLessonMap[lessonNumbers[0]]!.split(':')[1]);

              int endLessonHour = int.parse(Convert
                  .endTimeLessonMap[lessonNumbers[lessonNumbers.length - 1]]!
                  .split(':')[0]);
              int endLessonMinute = int.parse(Convert
                  .endTimeLessonMap[lessonNumbers[lessonNumbers.length - 1]]!
                  .split(':')[1]);

              final eventTime = key.millisecondsSinceEpoch - (7 * 3600000);

              final eventToCreate = Event(4.toString());

              eventToCreate.title = schoolSchedule.subject;

              eventToCreate.start = DateTime.fromMillisecondsSinceEpoch(
                  eventTime + startLessonHour * 3600000 + startLessonMinute * 60000);
              eventToCreate.description = schoolSchedule.address;

              eventToCreate.end = DateTime.fromMillisecondsSinceEpoch(
                  eventTime + endLessonHour * 3600000 + endLessonMinute * 60000);

              final createEventResult =
                  await _deviceCalendarPlugin.createOrUpdateEvent(eventToCreate);
              schoolSchedule.id=createEventResult.data;
            }
          });

  }

  Future _addPersonalScheduleToCalendar( ) async {
      allPersonalSchedulesMap.forEach((key, value)async {
        for (var personalSchedule in value) {
          final int eventTime = key.millisecondsSinceEpoch - (7 * 3600000) ;
          int personalScheduleHour =
          int.parse(personalSchedule.timer!.split(':')[0]);
          int personalScheduleMinute =
          int.parse(personalSchedule.timer!.split(':')[1]);

          final eventToCreate = Event(4.toString());

          eventToCreate.title = personalSchedule.name;

          eventToCreate.start = DateTime.fromMillisecondsSinceEpoch(eventTime + personalScheduleHour * 3600000 +
              personalScheduleMinute * 60000);
          debugPrint(DateTime.fromMillisecondsSinceEpoch(eventTime).toString());
          eventToCreate.description = personalSchedule.note;

          eventToCreate.end = DateTime.fromMillisecondsSinceEpoch(eventTime + personalScheduleHour * 3600000 +
              personalScheduleMinute * 60000 );
          final createEventResult =
          await _deviceCalendarPlugin.createOrUpdateEvent(eventToCreate);
          debugPrint('createEventResult '+createEventResult.isSuccess.toString()+'  '+createEventResult.data.toString());

        personalSchedule.id=createEventResult.data;
        }

      });
  }

  Future _deleteSchoolSchedule( ) async {
    allSchoolSchedulesMap.forEach((key, value) async{
      for (var schoolSchedule in value)  {

        final deleteEventResult =
            await _deviceCalendarPlugin.deleteEvent(4.toString(), schoolSchedule.id);
        debugPrint('_deleteSchoolSchedule '+ deleteEventResult.isSuccess.toString());
      }
    });

  }

  Future _deletePersonalSchedule(  ) async {
    allPersonalSchedulesMap.forEach((key, value)async {
    for (var personalSchedule in value) {
      final deleteEventResult = await _deviceCalendarPlugin.deleteEvent(
          4.toString(), personalSchedule.id);
      debugPrint('_deletePersonalSchedule '+deleteEventResult.isSuccess.toString());
        }
    });
  }

  Stream<ProfileState> _mapGetAllSchoolSchedulesToMap() async* {
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

  Stream<ProfileState> _mapGetAllPersonalScheduleToMap() async* {
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
