import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:schedule/common/utils/convert.dart';
import 'package:schedule/presentation/journey/home/calendar_tab_constants.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/presentation/widget/widgets_constants.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../blocs/blocs.dart';

class CalendarView extends StatefulWidget {
  final CalendarLoadDataSuccessState? state;

  const CalendarView({Key? key, this.state}) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          color: Color(0xffFCFAF3)),
      child: TableCalendar(
        currentDay: _selectedDay,
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        eventLoader: _getEventsForDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: ThemeText.dayOfWeekStyle,
            weekendStyle: ThemeText.dayOfWeekStyle
                .copyWith(color: AppColor.weekendTextColor)),
        calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            markerDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CalendarTabConstants.markerColor),
            todayDecoration: BoxDecoration(
                shape: BoxShape.circle, color: CalendarTabConstants.todayColor),
            selectedDecoration:
                BoxDecoration(color: CalendarTabConstants.selectedDayColor),
            markerSize: CalendarTabConstants.markerSize,
            rangeHighlightColor: CalendarTabConstants.selectedDayColor as Color,
            markersMaxCount: 1,
            outsideDaysVisible: true,
            weekendTextStyle:
                TextStyle(color: CalendarTabConstants.weekendTextColor),
            selectedTextStyle:
                TextStyle(color: CalendarTabConstants.dayTextColor),
            todayTextStyle:
                TextStyle(color: CalendarTabConstants.dayTextColor)),
        headerStyle: HeaderStyle(
          titleTextStyle:
              ThemeText.titleStyle.copyWith(color: AppColor.thirdColor),
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: Icon(
            Icons.arrow_back_ios,
            size: CalendarTabConstants.iconSize,
          ),
          rightChevronIcon: Icon(
            Icons.arrow_forward_ios,
            size: CalendarTabConstants.iconSize,
          ),
        ),
        onDaySelected: (
          selectedDay,
          focusedDay,
        ) =>
            _onDaySelected(selectedDay, focusedDay, context),
      ),
    );
  }

  List _getEventsForDay(DateTime day) {
    DateTime dateTime = Convert.dateConvert(
        DateTime.fromMillisecondsSinceEpoch(day.millisecondsSinceEpoch));
    return this.widget.state!.allSchedulesCalendarMap[
            DateTime.fromMillisecondsSinceEpoch(day.millisecondsSinceEpoch)] ??
        [];
  }

  void _onDaySelected(
      DateTime selectedDay, DateTime focusedDay, BuildContext context) {
    if (!isSameDay(_selectedDay, selectedDay))
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

    BlocProvider.of<ScheduleBloc>(context)
      ..add(GetScheduleDayEvent(
          selectDay: selectedDay,
          allSchedulesSchoolMap: this.widget.state!.allSchedulesSchoolMap,
          allSchedulePersonalMap: this.widget.state!.allSchedulePersonalMap));
  }
}
