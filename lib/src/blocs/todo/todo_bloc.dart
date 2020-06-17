import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/src/blocs/blocs.dart';
import 'package:schedule/src/models/model.dart';
import 'package:schedule/src/service/services.dart';
import 'package:schedule/src/utils/utils.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  CalendarBloc calendarBloc;
  RepositoryOffline _repositoryOffline = RepositoryOffline();
  String _date = DateTime.now().millisecondsSinceEpoch.toString();
  String _timer = '${Convert.timerConvert(TimeOfDay.now())}';

  TodoBloc({this.calendarBloc});

  @override
  // TODO: implement initialState
  TodoState get initialState =>
      TodoInitState(selectDay: _date, selectTimer: _timer);

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
      yield* _mapDetelePersonalScheduleToState(event.id);
  }

  Stream<TodoState> _mapSelectDatePickerToState(
      SelectDatePickerOnPressEvent event) async* {
    yield TodoLoadingState();
    _date = event.selectDay.millisecondsSinceEpoch.toString();
    yield TodoInitState(selectDay: _date, selectTimer: _timer);
  }

  Stream<TodoState> _mapSelectTimePickerToState(
      SelectTimePickerOnPressEvent event) async* {
    yield TodoLoadingState();
    _timer = Convert.timerConvert(event.timer);
    yield TodoInitState(selectTimer: _timer, selectDay: _date);
  }

  Stream<TodoState> _mapCreatePersonalScheduleToState(
      CreatePersonalScheduleOnPressEvent event) async* {
    yield TodoLoadingState();
    PersonalSchedule schedule =
        PersonalSchedule(this._date, event.name, this._timer, event.note);
    try {
      await _repositoryOffline.addPersonalScheduleRepo(schedule);
      _date = DateTime.now().millisecondsSinceEpoch.toString();
      _timer = '${Convert.timerConvert(TimeOfDay.now())}';
      calendarBloc.add(GetAllScheduleDataEvent());
      yield TodoSuccessState(true, selectTimer: _timer, selectDay: _date);
    } catch (e) {
      yield TodoFailureState(
          error: e.toString(), selectDay: this._date, selectTimer: this._timer);
    }
  }

  Stream<TodoState> _mapUpdatePersonalScheduleToState(
      UpdatePersonalScheduleOnPressEvent event) async* {
    yield TodoLoadingState();
    PersonalSchedule schedule = PersonalSchedule(
        this._date, event.name, this._timer, event.note,
        id: event.id);
    try {
      int flag = await _repositoryOffline.updatePersonalScheduleData(schedule);
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

  Stream<TodoState> _mapDetelePersonalScheduleToState(String id) async* {
    yield TodoLoadingState();
    try {
      int flag = await _repositoryOffline.deletePersonalScheduleRepo(id);
      if (flag == 1) {
        yield TodoSuccessState(true, selectTimer: _timer, selectDay: _date);
      }
    } catch (e) {
      yield TodoFailureState(
          error: e.toString(), selectDay: this._date, selectTimer: this._timer);
    }
  }
}
