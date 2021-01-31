import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TodoEvent extends Equatable {}

class TodoInitEvent extends TodoEvent{
  @override
  List<Object> get props => [];
}

class SelectDateEvent extends TodoEvent {
  final DateTime date;

  SelectDateEvent({@required this.date});

  @override
  List<Object> get props => [date];
}

class SelectTimeEvent extends TodoEvent {
  final DateTime time;

  SelectTimeEvent({@required this.time});

  @override
  List<Object> get props => [time];
}

class CreateTodoEvent extends TodoEvent {
  final String title;
  final String note;

  CreateTodoEvent(
      {@required this.title,
      @required this.note,});

  @override
  List<Object> get props => [];
}
