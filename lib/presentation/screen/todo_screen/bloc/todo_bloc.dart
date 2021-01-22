import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:schedule/domain/entities/personal_schedule.dart';
import 'package:schedule/domain/use_cases/todo_use_case.dart';
import 'package:schedule/presentation/screen/todo_screen/bloc/todo_event.dart';
import 'package:schedule/presentation/screen/todo_screen/bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoUseCase useCase;
  DateTime _date = DateTime.now();
  DateTime _time = DateTime.now();

  TodoBloc({@required this.useCase});

  @override
  TodoState get initialState => TodoInitState();

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is TodoInitEvent) {
      yield TodoSelectSuccess(
          time: DateFormat('kk:mm').format(_time),
          date: DateFormat('yyyy-MM-dd').format(_date));
    } else if (event is SelectDateEvent) {
      yield* _mapSelectDateEventToState(event);
    } else if (event is SelectTimeEvent) {
      yield* _mapSelectTimeEventToState(event);
    } else if (event is CreateTodoEvent)
      yield* _mapCreateTodoEventToState(event);
  }

  Stream<TodoState> _mapSelectDateEventToState(SelectDateEvent event) async* {
    yield TodoInitState();
    _date = event.date;
    yield TodoSelectSuccess(
        date: DateFormat('yyyy-MM-dd').format(_date),
        time: DateFormat('kk:mm').format(_time));
  }

  Stream<TodoState> _mapSelectTimeEventToState(SelectTimeEvent event) async* {
    yield TodoInitState();
    _time = event.time;
    yield TodoSelectSuccess(
        date: DateFormat('yyyy-MM-dd').format(_date),
        time: DateFormat('kk:mm').format(_time));
  }

  Stream<TodoState> _mapCreateTodoEventToState(CreateTodoEvent event) async* {
    yield TodoInitState();
    PersonalSchedule schedule = PersonalSchedule(
        title: event.title,
        note: event.note,
        times: DateFormat('kk:mm').format(_time),
        date: DateFormat('yyyy-MM-dd').format(_date));
    await useCase.createTodo(schedule);
    yield TodoCreateSuccess();
  }
}
