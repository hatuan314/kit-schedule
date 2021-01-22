import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/router_list.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/presentation/screen/home_screen/calendarView/widgets/event_item_widget.dart';
import 'package:schedule/presentation/screen/home_screen/home_bloc/home_bloc.dart';
import 'package:schedule/presentation/screen/home_screen/home_bloc/home_event.dart';
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
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
    _events = {
      _selectedDay.subtract(Duration(days: 30)): [
        'Event A0',
        'Event A0',
        'Event A0',
        'Event A0',
        'Event A0',
        'Event B0',
        'Event C0'
      ],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): [
        'Event A2',
        'Event B2',
        'Event C2',
        'Event D2',
        'Event D2',
        'Event D2',
        'Event D2',
        'Event D2',
        'Event D2',
        'Event D2',
      ],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): [
        'Event A4',
        'Event A4',
        'Event A4',
        'Event A4',
        'Event B4',
        'Event C4'
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        'Event A5',
        'Event B5',
        'Event B5',
        'Event B5',
        'Event B5',
        'Event B5',
        'Event C5'
      ],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8'
      ],
      _selectedDay.add(Duration(days: 3)):
          Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(Duration(days: 7)): [
        'Event A10',
        'Event B10',
        'Event B10',
        'Event B10',
        'Event C10'
      ],
      _selectedDay.add(Duration(days: 11)): [
        'Event A11',
        'Event B11',
        'Event B11',
        'Event B11',
        'Event B11'
      ],
      _selectedDay.add(Duration(days: 17)): [
        'Event A12',
        'Event B12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
      _selectedDay.add(Duration(days: 22)): [
        'Event A13',
        'Event B13',
        'Event B13',
        'Event B13',
        'Event B13',
        'Event B13'
      ],
      _selectedDay.add(Duration(days: 26)): [
        'Event A14',
        'Event B14',
        'Event B14',
        'Event B14',
        'Event B14',
        'Event B14',
        'Event C14'
      ],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {
        ///scrolling
        BlocProvider.of<HomeBloc>(context).add(ScrollEvent());
      });
      scrollController.position.isScrollingNotifier.addListener(() {
        if(!scrollController.position.isScrollingNotifier.value) {
          /// scroll stop
          BlocProvider.of<HomeBloc>(context).add(ScrollStopEvent());
        } else {
          ///print('scroll is started');
        }
      });
    });

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
    setState(() {
      _selectedEvents = events;
    });
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // Switch out 2 lines below to play with TableCalendar's settings
          //-----------------------
          //_buildTableCalendar(),
          _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          //_buildButtons(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
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

  Widget searchWidget() {
    final dateTime = _events.keys.elementAt(_events.length - 2);
    return IconButton(
        icon: Icon(
          Icons.search,
          color: ThemeColor.secondColor,
          size: 30,
        ),
        onPressed: () {
          Navigator.pushNamed(context, RouterList.search);
          // _calendarController.setSelectedDay(
          //   DateTime(dateTime.year, dateTime.month, dateTime.day),
          //   runCallback: true,
          // );
        });
  }

  // Simple TableCalendar configuration (using Styles)
  /*Widget _buildTableCalendar() {
    return TableCalendar(
      drawerWidget: drawerNavigationWidget(),
      searchWidget: searchWidget(),
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.blue,
        outsideDaysVisible: true,
      ),
      headerStyle: HeaderStyle(
        drawerWidgetVisible: true,
        searchWidgetVisible: true,
        formatButtonVisible: false,
        rightChevronVisible: false,
        leftChevronVisible: false,
        formatButtonTextStyle:
        TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      headerVisible: true,
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }
*/
  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      drawerWidget: drawerNavigationWidget(),
      searchWidget: searchWidget(),
      calendarController: _calendarController,
      events: _events,
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

  Widget _buildButtons() {
    final dateTime = _events.keys.elementAt(_events.length - 2);

    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text(
              'Set day ${dateTime.day}-${dateTime.month}-${dateTime.year}'),
          onPressed: () {
            _calendarController.setSelectedDay(
              DateTime(dateTime.year, dateTime.month, dateTime.day),
              runCallback: true,
            );
          },
        ),
      ],
    );
  }

  Widget _buildEventList() {
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
              if(distance<-5)
                {
                  setState(() {
                    _calendarController.setCalendarFormat(CalendarFormat.twoWeeks);
                  });
                } else if(distance>5)
                  {
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
            child: ListView.builder(
              controller: scrollController,
              itemCount: _selectedEvents.length,
              itemBuilder: (context, position) {
                return EventItemWidget(
                  startTime: '7:00',
                  endTime: '9:00',
                  title: 'Nguyên lý hệ điều hànhđiều hànhđiều hànhđiều hànhđiều hànhđiều hành',
                  note: 'note',);
              },
            ),
          )
        ],
      ),
    );
  }
}
