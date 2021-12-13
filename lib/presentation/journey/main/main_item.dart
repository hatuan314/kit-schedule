import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/presentation/journey/home/calendar_tab_screen.dart';
import 'package:schedule/presentation/journey/profile/profile_screen.dart';
import 'package:schedule/presentation/journey/scores/scores_screen.dart';
import 'package:schedule/presentation/journey/todo_screen/todo_screen.dart';

enum MainItem {
  CalendarTabScreenItem,
  ScoresScreenItem,
  TodoScreenItem,
  ProfileScreenItem
}

extension MainItemExtension on MainItem {
  Widget getScreen() {
    switch (this) {
      case MainItem.CalendarTabScreenItem:
        return CalendarTabScreen();
      case MainItem.ScoresScreenItem:
        return ScoresScreen();
      case MainItem.TodoScreenItem:
        return TodoScreen();
      case MainItem.ProfileScreenItem:
        return ProfileScreen();
    }
  }

  int getIndex() {
    switch (this) {
      case MainItem.CalendarTabScreenItem:
        return 0;
      case MainItem.ScoresScreenItem:
        return 1;
      case MainItem.TodoScreenItem:
        return 2;
      case MainItem.ProfileScreenItem:
        return 3;
    }
  }

  IconData getIcon() {
    switch (this) {
      case MainItem.CalendarTabScreenItem:
        return Icons.date_range;
      case MainItem.ScoresScreenItem:
        return Icons.score_outlined;
      case MainItem.ProfileScreenItem:
        return Icons.person;
      case MainItem.TodoScreenItem:
        return Icons.content_paste;
    }
  }
}
