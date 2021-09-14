import 'dart:developer';

import 'package:device_calendar/device_calendar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/blocs/blocs.dart';
import 'package:schedule/common/utils/convert.dart';
import 'package:schedule/domain/entities/personal_schedule_entities.dart';
import 'package:schedule/domain/usecase/personal_usecase.dart';
import 'package:schedule/presentation/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:schedule/presentation/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:schedule/presentation/bloc/snackbar_bloc/snackbar_type.dart';
import 'package:schedule/service/share_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  CalendarBloc? calendarBloc;
  late final String msv;

  ShareService shareService = ShareService();
  DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();

  List<Calendar> _calendars = [];

  String _date = DateTime.utc(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 0, 0, 0, 0)
      .millisecondsSinceEpoch
      .toString();
  String _timer = '${Convert.timerConvert(TimeOfDay.now())}';
  SnackbarBloc snackbarBloc;
  final PersonalUseCase personalUS;

  TodoBloc(
      {this.calendarBloc, required this.snackbarBloc, required this.personalUS})
      : super(TodoInitState(
            selectDay: DateTime.utc(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day, 0, 0, 0, 0)
                .millisecondsSinceEpoch
                .toString(),
            selectTimer: '${Convert.timerConvert(TimeOfDay.now())}'));

  // @override
  // // TODO: implement initialState
  // TodoState get initialState =>
  //     TodoInitState(selectDay: _date, selectTimer: _timer);

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    // TODO: implement mapEventToState
    if (event is SelectDatePickerOnPressEvent)
      yield* _mapSelectDatePickerToState(event);
    else if (event is SelectTimePickerOnPressEvent)
      yield* _mapSelectTimePickerToState(event);
    else if (event is CreatePersonalScheduleOnPressEvent)
      yield* _mapCreatePersonalScheduleToState(event);
    else if (event is UpdatePersonalScheduleOnPressEvent)
      yield* _mapUpdatePersonalScheduleToState(event);
    else if (event is DetelePersonalScheduleOnPressEvent)
      yield* _mapDetelePersonalScheduleToState(event.personal);
    else if (event is GetUserNameEvent) {
      msv = (await ShareService().getUsername() as String);
    }
  }

  Stream<TodoState> _mapSelectDatePickerToState(
      SelectDatePickerOnPressEvent event) async* {
    yield TodoLoadingState();
    _date = event.selectDay!.millisecondsSinceEpoch.toString();
    yield TodoInitState(selectDay: _date, selectTimer: _timer);
  }

  Stream<TodoState> _mapSelectTimePickerToState(
      SelectTimePickerOnPressEvent event) async* {
    yield TodoLoadingState();
    _timer = Convert.timerConvert(event.timer!);
    yield TodoInitState(selectTimer: _timer, selectDay: _date);
  }

  Stream<TodoState> _mapCreatePersonalScheduleToState(
      CreatePersonalScheduleOnPressEvent event) async* {
    yield TodoLoadingState(selectDay: this._date, selectTimer: this._timer);
    final String now = DateTime.now().millisecondsSinceEpoch.toString();
    bool hasNoti = await shareService.getHasNoti() ?? false;
    String id = '';
    String date = DateTime.parse(
            DateTime.fromMillisecondsSinceEpoch(int.parse(this._date))
                .toString()
                .substring(0, 10))
        .millisecondsSinceEpoch
        .toString();
    if (hasNoti) {
      //1630772220386
      debugPrint(
          DateTime.fromMillisecondsSinceEpoch(int.parse(date)).toString());
      await _retrieveCalendars();
      id = await _addPersonalScheduleToCalendar(PersonalScheduleEntities(
        date: date,
        name: event.name,
        timer: this._timer,
        note: event.note,
        updateAt: now,
        createAt: now,
      ));
    }
    PersonalScheduleEntities schedule(bool isSynch) {
      PersonalScheduleEntities schedule = PersonalScheduleEntities(
        id: id,
        date: date,
        name: event.name,
        timer: this._timer,
        note: event.note,
        isSynchronized: isSynch,
        updateAt: now,
        createAt: now,
      );
      debugPrint('todo id: ' + (schedule.id ?? ''));
      return schedule;
    }

    try {
      // bool hasNoti= await shareService.getHasNoti() ?? false;
      // if(hasNoti)
      //   {
      //     await _retrieveCalendars();
      //     await _addPersonalScheduleToCalendar(schedule(true));
      //   }
      String result =
          await personalUS.syncPersonalSchoolDataFirebase(msv, schedule(true));
      if (result.isNotEmpty) {
        log('Not Empty');
        await personalUS.insertPersonalSchedule(schedule(true));
      } else {
        log('empty');
        await personalUS.insertPersonalSchedule(schedule(false));
      }
      _date = DateTime.now().millisecondsSinceEpoch.toString();
      _timer = '${Convert.timerConvert(TimeOfDay.now())}';
      calendarBloc!.add(GetAllScheduleDataEvent());
      snackbarBloc.add(ShowSnackbar(
          title: '${SnackBarTitle.CreateSuccess}', type: SnackBarType.success));
      yield TodoSuccessState(true, selectTimer: _timer, selectDay: _date);
      // String msv=await ShareService().getUsername() as String;
    } catch (e) {
      snackbarBloc.add(ShowSnackbar(
          title: '${SnackBarTitle.ConnectionFailed}',
          type: SnackBarType.error));
      yield TodoFailureState(
          error: e.toString(), selectDay: this._date, selectTimer: this._timer);
    }
  }

  Stream<TodoState> _mapUpdatePersonalScheduleToState(
      UpdatePersonalScheduleOnPressEvent event) async* {
    yield TodoLoadingState(selectDay: this._date, selectTimer: this._timer);
    final String now = DateTime.now().millisecondsSinceEpoch.toString();
    bool hasNoti = await shareService.getHasNoti() ?? false;
    String id = '';
    if (hasNoti) {
      await _retrieveCalendars();
      debugPrint('delete  id : ' + event.id);
      final deleteEventResult =
          await _deviceCalendarPlugin.deleteEvent(_calendars[0].id, event.id);
      debugPrint('delete' + deleteEventResult.isSuccess.toString());
      id = await _addPersonalScheduleToCalendar(PersonalScheduleEntities(
          date: this._date,
          name: event.name,
          timer: this._timer,
          note: event.note,
          createAt: event.createAt,
          updateAt: now));
    }
    debugPrint('update id: ' + id);
    PersonalScheduleEntities schedule(bool isSynch) {
      PersonalScheduleEntities schedule = PersonalScheduleEntities(
          date: this._date,
          name: event.name,
          timer: this._timer,
          note: event.note,
          id: id,
          createAt: event.createAt,
          updateAt: now);

      debugPrint('aaaaaaaaaaaaaaaaaaaaaaa${schedule.id}');
      return schedule;
    }

    int flag;
    try {
      final result =
          await personalUS.syncPersonalSchoolDataFirebase(msv, schedule(true));
      if (result.isNotEmpty) {
        flag = await personalUS.updatePersonalScheduleData(schedule(true));
      } else {
        flag = await personalUS.updatePersonalScheduleData(schedule(false));
      }
      _date = DateTime.now().millisecondsSinceEpoch.toString();
      _timer = '${Convert.timerConvert(TimeOfDay.now())}';
      if (flag == 1) {
        yield TodoSuccessState(true, selectTimer: _timer, selectDay: _date);
      }
    } catch (e) {
      yield TodoFailureState(
          error: e.toString(), selectDay: this._date, selectTimer: this._timer);
    }
  }

  Stream<TodoState> _mapDetelePersonalScheduleToState(
      PersonalScheduleEntities personal) async* {
    yield TodoLoadingState(selectDay: this._date, selectTimer: this._timer);
    //  debugPrint('delete  id : ' + (personal.id as String));
    bool hasNoti = await shareService.getHasNoti() ?? false;
    if (hasNoti) {
      await _retrieveCalendars();
      debugPrint('delete  id : ' + (personal.id as String));
      final deleteEventResult = await _deviceCalendarPlugin.deleteEvent(
          _calendars[0].id, personal.id);
      debugPrint('delete' + deleteEventResult.isSuccess.toString());
    }
    personal.updateAt = "0";
    String result = await personalUS.deletePersonalSchoolDataFirebase(
        msv, personal.createAt!);
    int flag;
    if (result.isNotEmpty) {
      flag = await personalUS.deletePersonalScheduleLocal(personal);
    } else {
      //nếu không thành công lưu update=0 để lần sau đồng bộ lại
      personal.updateAt = '0';
      flag = await personalUS.updatePersonalScheduleData(personal);
    }
    if (flag == 1) {
      yield TodoSuccessState(true, selectTimer: _timer, selectDay: _date);
    } else {
      yield TodoFailureState(
          error: 'save failure',
          selectDay: this._date,
          selectTimer: this._timer);
    }
  }

  _retrieveCalendars() async {
    try {
      var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
      if (permissionsGranted.isSuccess && !permissionsGranted.data!) {
        permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
        if (!permissionsGranted.isSuccess || !permissionsGranted.data!) {
          return;
        }
      }
      final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();

      _calendars = calendarsResult.data as List<Calendar>;
    } catch (e) {
      print(e);
    }
  }

  Future<String> _addPersonalScheduleToCalendar(
      PersonalScheduleEntities personalSchedule) async {
    int personalScheduleHour = int.parse(personalSchedule.timer!.split(':')[0]);
    int personalScheduleMinute =
        int.parse(personalSchedule.timer!.split(':')[1]);
    final int eventTime = (int.parse(personalSchedule.date as String));
    final eventToCreate =
        Event(_calendars[0].id, availability: Availability.Busy);
    debugPrint(DateTime.fromMillisecondsSinceEpoch(eventTime +
            personalScheduleHour * 3600000 +
            personalScheduleMinute * 60000)
        .toString());
    debugPrint(DateTime.fromMillisecondsSinceEpoch(eventTime).toString());
    eventToCreate.title = personalSchedule.name;
    eventToCreate.start = Convert.getTz(DateTime.fromMillisecondsSinceEpoch(
        eventTime +
            personalScheduleHour * 3600000 +
            personalScheduleMinute * 60000));
    eventToCreate.description = personalSchedule.note;
    eventToCreate.end = eventToCreate.start;
    final createEventResult =
        await _deviceCalendarPlugin.createOrUpdateEvent(eventToCreate);
    debugPrint('createEventResult: ' + createEventResult!.isSuccess.toString());
    return createEventResult.data!;
  }
}
