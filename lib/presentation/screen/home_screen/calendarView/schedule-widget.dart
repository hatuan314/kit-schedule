import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/router_list.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/domain/entities/school_entity.dart';
import 'package:schedule/presentation/screen/home_screen/calendarView/bloc/calendar_bloc.dart';
import 'package:schedule/presentation/screen/home_screen/calendarView/bloc/calendar_event.dart';
import 'package:schedule/presentation/screen/home_screen/calendarView/bloc/calendar_state.dart';
import 'package:schedule/presentation/screen/home_screen/calendarView/widgets/event_item_widget.dart';
import 'package:schedule/presentation/screen/home_screen/calendarView/widgets/search_widget.dart';
import 'package:schedule/presentation/screen/home_screen/home_bloc/home_bloc.dart';
import 'package:schedule/presentation/screen/home_screen/home_bloc/home_event.dart';
import 'package:schedule/src/utils/convert.dart';
import 'package:schedule/utils/table_calendar-2.3.3/table_calendar.dart';

class ScheduleWidget extends StatefulWidget {
  final AnimationController drawerController;

  const ScheduleWidget({Key key, this.drawerController}) : super(key: key);

  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget>
    with TickerProviderStateMixin {
  double distance;
  double initial;
  ScrollController scrollController = ScrollController();
  final Map<DateTime, List> _holidays = {
    DateTime(2020, 1, 1): ['New Year\'s Day'],
    DateTime(2020, 1, 6): ['Epiphany'],
    DateTime(2020, 2, 14): ['Valentine\'s Day'],
    DateTime(2020, 4, 21): ['Easter Sunday'],
    DateTime(2020, 4, 22): ['Easter Monday'],
  };

  AnimationController _animationController;
  CalendarController _calendarController;
  bool listenInitial = false;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CalendarBloc>(context).add(CalendarInitEvent());
    BlocProvider.of<CalendarBloc>(context).add(CalendarSelectDayEvent(selectedDay: Convert.dateConvert(DateTime.now())));
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );


    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');

  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<CalendarBloc, CalendarState>(
            listener: (BuildContext context, state) {
              if(state is CalendarInitState && listenInitial == false)
                {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    scrollController.addListener(() {
                      ///scrolling
                      BlocProvider.of<HomeBloc>(context).add(ScrollEvent());
                    });
                    scrollController.position.isScrollingNotifier.addListener(() {
                      if (!scrollController.position.isScrollingNotifier.value) {
                        /// scroll stop
                        BlocProvider.of<HomeBloc>(context).add(ScrollStopEvent());
                      } else {
                        ///print('scroll is started');
                      }
                    });
                  });
                  listenInitial=true;
                }
            },
            builder: (BuildContext context, state) {
              if (state is CalendarInitState) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    // Switch out 2 lines below to play with TableCalendar's settings
                    //-----------------------
                    //_buildTableCalendar(),
                    _buildTableCalendarWithBuilders(
                        allEvent: state.allSchedule),
                    const SizedBox(height: 8.0),
                    //_buildButtons(),
                    const SizedBox(height: 8.0),
                    Expanded(child: _buildEventList(state)),
                  ],
                );
              }
              return Container();
            }));
  }

  Widget drawerNavigationWidget() {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          color: ThemeColor.secondColor,
          progress: widget.drawerController,
        ),
        onPressed: () {
          BlocProvider.of<HomeBloc>(context).add(SwitchDrawerEvent());
        });
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders({Map<DateTime, dynamic> allEvent}) {
    return TableCalendar(
      drawerWidget: drawerNavigationWidget(),
      searchWidget: searchWidget(() {
        Navigator.pushNamed(context, RouterList.search);
      }),
      calendarController: _calendarController,
      events: allEvent,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        highlightToday: false,
        outsideDaysVisible: false,
        //selectedStyle: TextStyle().copyWith(color: ThemeColor.selectedDayBackgroundColor),
        weekendStyle: TextStyle().copyWith(color: ThemeColor.weekendTextColor),
        weekdayStyle: TextStyle().copyWith(color: ThemeColor.weekDayTextColor),
        eventDayStyle:
            TextStyle().copyWith(color: ThemeColor.eventDayTextColor),
        //outsideStyle: TextStyle().copyWith(color: Colors.lightBlue),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle().copyWith(color: ThemeColor.thirdColor),
        weekendStyle: TextStyle().copyWith(color: ThemeColor.weekendTextColor),
      ),
      headerStyle: HeaderStyle(
        headerMargin: EdgeInsets.symmetric(horizontal: 10),
        titleTextStyle: TextStyle().copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: ThemeColor.secondColor),
        drawerWidgetVisible: true,
        searchWidgetVisible: true,
        formatButtonVisible: false,
        rightChevronVisible: false,
        leftChevronVisible: false,
        centerHeaderTitle: true,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              decoration: BoxDecoration(
                color: ThemeColor.selectedDayBackgroundColor,
                borderRadius: new BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(
                    fontSize: 16.0, color: ThemeColor.selectedDayTextColor),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle()
                  .copyWith(fontSize: 16.0, color: ThemeColor.todayTextColor),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events, holidays) {
        _onDaySelected(date, events, holidays);
        BlocProvider.of<CalendarBloc>(context).add(CalendarSelectDayEvent(selectedDay: date));
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(10.0),
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildEventList(CalendarInitState state) {

    return Container(
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
          color: ThemeColor.secondColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: Column(
        children: [
          GestureDetector(
            onPanStart: (DragStartDetails details) {
              initial = details.globalPosition.dy;
            },
            onPanUpdate: (DragUpdateDetails details) {
              distance = details.globalPosition.dy - initial;
            },
            onPanEnd: (DragEndDetails details) {
              initial = 0.0;
              print(distance);
              if (distance < -5) {
                setState(() {
                  _calendarController
                      .setCalendarFormat(CalendarFormat.twoWeeks);
                });
              } else if (distance > 5) {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              }
              //+ve distance signifies a drag from left to right(start to end)
              //-ve distance signifies a drag from right to left(end to start)
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.sp),
              width: ScreenUtil().screenWidth,
              child: Text(
                'Events',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              ),
            ),
          ),
          Expanded(
            child: (state.listScheduleOfDay!=null) ? ListView.builder(
              controller: scrollController,
              itemCount: state.listScheduleOfDay.length,
              itemBuilder: (context, index) {
                List lessonNumbers = state.listScheduleOfDay[index].lesson.split(',');
                String startLesson = lessonNumbers[0];
                String endLesson = lessonNumbers[lessonNumbers.length - 1];
                return EventItemWidget(
                  startTime: Convert.startTimeLessonMap[startLesson],
                  endTime: Convert.endTimeLessonMap[endLesson],
                  title: state.listScheduleOfDay[index].subject,
                  note: state.listScheduleOfDay[index].address,
                );
              },
            ) : Text('No data')
          )
        ],
      ),
    );
  }
}
