import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SearchEvent extends Equatable {
}
class SearchInitEvent extends SearchEvent {
  @override
  List<Object> get props => [];
}
class SearchScheduleEvent extends SearchEvent {
  final String eventName;

  SearchScheduleEvent({@required this.eventName});
  @override
  List<Object> get props => [eventName];
}