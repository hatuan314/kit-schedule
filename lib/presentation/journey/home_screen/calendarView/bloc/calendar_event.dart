import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CalendarEvent extends Equatable {
}
class CalendarInitEvent extends CalendarEvent {
  @override
  List<Object> get props => [];
}

class CalendarSelectDayEvent extends CalendarEvent {
  final DateTime selectedDay;

  CalendarSelectDayEvent({this.selectedDay});

  @override
  List<Object> get props => [selectedDay];
}