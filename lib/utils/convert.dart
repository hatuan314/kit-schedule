import 'package:flutter/material.dart';

class Convert {
  static Map<String, String> startTimeLessonMap = {
    '1': '07:00',
    '2': '07:50',
    '3': '08:40',
    '4': '09:35',
    '5': '10:25',
    '6': '11:15',
    '7': '12:30',
    '8': '13:20',
    '9': '14:10',
    '10': '15:05',
    '11': '15:55',
    '12': '16:45',
    '13': '18:00'
  };

  static Map<String, String> endTimeLessonMap = {
    '1': '07:45',
    '2': '08:35',
    '3': '09:25',
    '4': '10:20',
    '5': '11:10',
    '6': '12:55',
    '7': '13:15',
    '8': '14:05',
    '9': '14:55',
    '10': '15:55',
    '11': '16:40',
    '12': '17:30',
    '16': '21:15'
  };

  static DateTime dateConvert(DateTime time) {
    int year = time.year;
    int month = time.month;
    int day = time.day;
    return DateTime(year, month, day, 7, 0);
  }

  static timerConvert(TimeOfDay timer) {
    String happyHour = timer.hour.toString();
    String happyMinite = timer.minute.toString();
    if (timer.hour < 10) happyHour = '0${timer.hour}';
    if (timer.minute < 10) happyMinite = '0${timer.minute}';
    return '$happyHour:$happyMinite';
  }
}
