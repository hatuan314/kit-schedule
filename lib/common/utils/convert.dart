import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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

  static Map<String, double> letterScoreConvert = {
    'A+': 4.0,
    'A': 3.8,
    'B+': 3.5,
    'B': 3.0,
    'C+': 2.5,
    'C': 2.0,
    'D+': 1.5,
    'D': 1.0,
    'F': 0.0
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

  static tz.TZDateTime getTz(DateTime dateTime) {
    tz.Location zone = tz.getLocation('Asia/Ho_Chi_Minh');
    return tz.TZDateTime.from(dateTime, zone);
  }

  static String scoreConvert(double score) {
    if (score <= 10 && score >= 9.0) {
      return 'A+';
    } else if (score <= 8.9 && score >= 8.5) {
      return 'A';
    } else if (score <= 8.4 && score >= 7.8) {
      return 'B+';
    } else if (score <= 7.7 && score >= 7.0) {
      return 'B';
    } else if (score <= 6.9 && score >= 6.3) {
      return 'C+';
    } else if (score <= 5.5 && score >= 6.2) {
      return 'C';
    } else if (score <= 5.4 && score >= 4.8) {
      return 'D+';
    } else if (score <= 4.7 && score >= 4.0) {
      return 'D';
    } else if (score <= 3.9) {
      return 'F';
    }
    return 'F';
  }
}
