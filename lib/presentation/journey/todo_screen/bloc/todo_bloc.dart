import 'dart:developer';

import 'package:equatable/equatable.dart';
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

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  CalendarBloc? calendarBloc;

  String _date = DateTime.now().millisecondsSinceEpoch.toString();
  String _timer = '${Convert.timerConvert(TimeOfDay.now())}';
  SnackbarBloc snackbarBloc;
  final PersonalUseCase personalUS;
  TodoBloc(
      {this.calendarBloc, required this.snackbarBloc, required this.personalUS})
      : super(TodoInitState(
            selectDay: DateTime.now().millisecondsSinceEpoch.toString(),
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
    yield TodoLoadingState();
    final String now = DateTime.now().millisecondsSinceEpoch.toString();
    PersonalScheduleEntities schedule(bool isSynch) {
      PersonalScheduleEntities schedule = PersonalScheduleEntities(
        date: this._date,
        name: event.name,
        timer: this._timer,
        note: event.note,
        isSynchronized: isSynch,
        updateAt: now,
        createAt: now,
      );
      return schedule;
    }

    try {
      String result = await personalUS.syncPersonalSchoolDataFirebase(
          "AT160543", schedule(true));
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
      snackbarBloc.add(
          ShowSnackbar(title: 'Create Success', type: SnackBarType.success));
      yield TodoSuccessState(true, selectTimer: _timer, selectDay: _date);
      // String msv=await ShareService().getUsername() as String;
    } catch (e) {
      snackbarBloc
          .add(ShowSnackbar(title: 'Create Failed', type: SnackBarType.error));
      yield TodoFailureState(
          error: e.toString(), selectDay: this._date, selectTimer: this._timer);
    }
  }

  Stream<TodoState> _mapUpdatePersonalScheduleToState(
      UpdatePersonalScheduleOnPressEvent event) async* {
    yield TodoLoadingState();
    final String now = DateTime.now().millisecondsSinceEpoch.toString();
    PersonalScheduleEntities schedule(bool isSynch) {
      PersonalScheduleEntities schedule = PersonalScheduleEntities(
          date: this._date,
          name: event.name,
          timer: this._timer,
          note: event.note,
          id: event.id,
          createAt: event.createAt,
          updateAt: now);
      return schedule;
    }

    int flag;
    try {
      log('${schedule(true).createAt}');
      final result = await personalUS.syncPersonalSchoolDataFirebase(
          'AT160543', schedule(true));
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
    yield TodoLoadingState();
    personal.updateAt="0";
    String result =await personalUS.syncPersonalSchoolDataFirebase('AT160543',personal);
    int flag;
    if(result.isNotEmpty){
      flag = await personalUS.deletePersonalScheduleLocal(personal);
    }else{//nếu không thành công lưu update=0 để lần sau đồng bộ lại
      personal.updateAt='0';
      flag=await personalUS.updatePersonalScheduleData(personal);
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
}
