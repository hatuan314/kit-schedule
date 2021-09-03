import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:schedule/common/utils/convert.dart';
import 'package:schedule/domain/entities/personal_schedule_entities.dart';
import 'package:schedule/domain/entities/school_schedule_entities.dart';
import 'package:schedule/domain/usecase/personal_usecase.dart';
import 'package:schedule/domain/usecase/schedule_usecase.dart';

import 'package:schedule/presentation/bloc/snackbar_bloc/bloc.dart';
import 'package:schedule/presentation/bloc/snackbar_bloc/snackbar_type.dart';
import 'package:schedule/presentation/journey/sign_in_screen.dart/bloc/register_state.dart';
import 'package:schedule/service/services.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  ShareService _shareService = ShareService();
  final SnackbarBloc snackbarBloc;
  final ScheduleUseCase scheduleUseCase;
  final PersonalUseCase personalUseCase;

  // late DeviceCalendarPlugin _deviceCalendarPlugin;

  // late List<Calendar>? _calendars;
  RegisterBloc(
      {required this.snackbarBloc,
      required this.personalUseCase,
      required this.scheduleUseCase})
      : super(RegisterInitState());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    // TODO: implement mapEventToState
    if (event is ShowPasswordOnPress) {
      if (event.isShow) {
        yield RegisterShowPasswordState(true);
      } else {
        yield RegisterShowPasswordState(false);
      }
    } else if (event is SignInOnPressEvent) {
      yield RegisterLoadingState();
      String account = event.account;
      String password = md5.convert(utf8.encode(event.password)).toString();
      bool isSaveUsername = await ShareService().setUsername(event.account);
      try {
        var data =
            await scheduleUseCase.fetchScheduleSchoolData(account, password);
        if (data!.isEmpty) {
          snackbarBloc.add(ShowSnackbar(
              title: 'No Data. Try again', type: SnackBarType.error));
          yield RegisterNoDataState();
        } else {
          List<PersonalScheduleEntities> list =
              await personalUseCase.fetchPersonalSchoolDataFirebase(account);
          await _savePersonalSchool(list, state);
          await _saveScheduleSchool(data, state);
          await _shareService.setIsSaveData(true);
          // data.forEach((key, value) async{
          //   await _addEventsToCalendar(value);
          // });
          //   await _retrieveCalendars();

          //    _calendars?.forEach((element) { log(element.id);});

          yield RegisterSuccessState();
        }
      } catch (e) {
        snackbarBloc.add(
            ShowSnackbar(title: 'Connection Failed', type: SnackBarType.error));
        yield RegisterFailureState(e.toString());
      }
    }
  }

  //   _retrieveCalendars() async {
  //   try {
  //     var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
  //     if (permissionsGranted.isSuccess && !permissionsGranted.data) {
  //       permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
  //       if (!permissionsGranted.isSuccess || !permissionsGranted.data) {
  //         return;
  //       }
  //     }
  //
  //     final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
  //       _calendars = calendarsResult?.data;
  //
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Event _buildEvent(
      {required String title,
      String? description,
      String? location,
      required DateTime startDate,
      required DateTime endDate}) {
    return Event(
      title: title,
      description: description == null ? '' : description,
      location: location == null ? '' : location,
      startDate: startDate,
      endDate: endDate,
      allDay: false,
      iosParams: IOSParams(),
      androidParams: AndroidParams(
        emailInvites: [],
      ),
    );
  }

  Future _addEventsToCalendar(List schoolList,) async {
    // var fightString = new StringBuffer('');
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    for (var schoolSchedule in schoolList) {

      List lessonNumbers = schoolSchedule.lesson!.split(',');
      int startLessonHour = int.parse(
          Convert.startTimeLessonMap[lessonNumbers[0]]!.split(':')[0]);
      int startLessonMinute = int.parse(
          Convert.startTimeLessonMap[lessonNumbers[0]]!.split(':')[1]);
      int endLessonHour = int.parse(
          Convert.endTimeLessonMap[lessonNumbers.length - 1]!.split(':')[0]);
      int endLessonMinute = int.parse(
          Convert.endTimeLessonMap[lessonNumbers.length - 1]!.split(':')[1]);
      final eventTime =
          DateTime.parse(schoolSchedule.date as String).millisecondsSinceEpoch -
              7 * 3600000;
      log(eventTime.toString());
      await Add2Calendar.addEvent2Cal(_buildEvent(
          title: schoolSchedule.subject as String,
          location: schoolSchedule.address,
          startDate: DateTime.fromMillisecondsSinceEpoch(eventTime +
              startLessonHour * 3600000 +
              startLessonMinute * 60000),
          endDate: DateTime.fromMillisecondsSinceEpoch(
              eventTime + endLessonHour * 3600000 + endLessonMinute * 60000)));
   log('add to calendar');
    }

    // for (var personalSchedule in personalList) {
    //   List lessonNumbers = schoolSchedule.lesson!.split(',');
    //   int startLessonHour = int.parse(
    //       Convert.startTimeLessonMap[lessonNumbers[0]]!.split(':')[0]);
    //   int startLessonMinute = int.parse(
    //       Convert.startTimeLessonMap[lessonNumbers[0]]!.split(':')[1]);
    //   int endLessonHour = int.parse(
    //       Convert.endTimeLessonMap[lessonNumbers.length - 1]!.split(':')[0]);
    //   int endLessonMinute = int.parse(
    //       Convert.endTimeLessonMap[lessonNumbers.length - 1]!.split(':')[1]);
    //   final eventTime =
    //       DateTime.parse(schoolSchedule.date as String).millisecondsSinceEpoch -
    //           7 * 3600000;
    //   await Add2Calendar.addEvent2Cal(_buildEvent(
    //       title: personalSchedule. as String,
    //       location: schoolSchedule.address,
    //       startDate: DateTime.fromMillisecondsSinceEpoch(eventTime +
    //           startLessonHour * 3600000 +
    //           startLessonMinute * 60000),
    //       endDate: DateTime.fromMillisecondsSinceEpoch(
    //           eventTime + endLessonHour * 3600000 + endLessonMinute * 60000)));
    // }
  }

  _savePersonalSchool(
      List<PersonalScheduleEntities> personal, RegisterState state) async {
    try {
      if (personal.isNotEmpty) {
        personal.forEach((element) async {
          await personalUseCase.insertPersonalSchedule(element);
        });
      }
    } catch (e) {
      debugPrint('RegisterBloc - saveSchoolSchedule - error: {$e}');
    }
  }

  _saveScheduleSchool(Map scheduleDataMap, RegisterState state) async {
    List dates = scheduleDataMap.keys.toList();
    List<SchoolSchedule> schoolSchedule = [];
    try {
      dates.forEach((date) {
        if (scheduleDataMap[date] != null || scheduleDataMap[date].length > 0)
          scheduleDataMap[date].forEach((scheduleJson) async {
            schoolSchedule.add(SchoolSchedule.fromJsonApi(scheduleJson, date));
          });
      });

      await scheduleUseCase.insertSchoolScheduleLocal(schoolSchedule);
    } catch (e) {
      debugPrint('RegisterBloc - saveSchoolSchedule - error: {$e}');
    }
  }
}
