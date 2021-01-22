import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TodoState extends Equatable {}

class TodoInitState extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoSelectSuccess extends TodoState {
  final String date;
  final String time;

  TodoSelectSuccess({@required this.date, @required this.time});

  @override
  List<Object> get props => [];
}

class TodoCreateSuccess extends TodoState {
  @override
  List<Object> get props => [];
}
