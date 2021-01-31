// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:schedule/src/blocs/calendar/calendar_bloc.dart';
// import 'package:schedule/src/blocs/schedules/schedule_bloc.dart';
// import 'package:schedule/utils/table_calendar-2.3.3/table_calendar.dart';
//
//
// class CalendarView extends StatefulWidget {
//   final CalendarLoadDataSuccessState state;
//   const CalendarView({Key key, this.state}) : super(key: key);
//   @override
//   _CalendarViewState createState() => _CalendarViewState();
// }
//
// class _CalendarViewState extends State<CalendarView> {
//   final CalendarController _calendarController = CalendarController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
//           color: Color(0xffFCFAF3)),
//       child: TableCalendar(
//         calendarController: _calendarController,
//         events: this.widget.state.allSchedulesCalendarMap,
//         startingDayOfWeek: StartingDayOfWeek.monday,
//         daysOfWeekStyle: DaysOfWeekStyle(
//             weekdayStyle:
//                 TextStyle(fontFamily: 'MR', fontWeight: FontWeight.w400),
//             weekendStyle: TextStyle(
//                 color: Colors.redAccent,
//                 fontFamily: 'MR',
//                 fontWeight: FontWeight.w400)),
//         calendarStyle: CalendarStyle(
//             selectedColor: Colors.blue[900],
//             todayColor: Color.fromRGBO(66, 165, 245, 0.6),
//             markersColor: Colors.blue[600],
//             markersMaxAmount: 1,
// //          markersPositionBottom: ScreenUtil().setHeight(20),
//             outsideDaysVisible: true,
//             weekendStyle: TextStyle(color: Colors.redAccent),
//             selectedStyle: TextStyle(color: Colors.white),
//             todayStyle: TextStyle(color: Colors.white)),
//         headerStyle: HeaderStyle(
//           titleTextStyle: TextStyle(
//               fontSize: ScreenUtil().setSp(32),
//               fontFamily: 'MR',
//               fontWeight: FontWeight.w500),
//           formatButtonVisible: false,
//           centerHeaderTitle: true,
//           leftChevronIcon: Icon(
//             Icons.arrow_back_ios,
//             size: ScreenUtil().setHeight(18),
//           ),
//           rightChevronIcon: Icon(
//             Icons.arrow_forward_ios,
//             size: ScreenUtil().setHeight(18),
//           ),
//         ),
//        /* onDaySelected: (selectDay, events) => ///todo : ondayselected
//             _onDaySelected(selectDay, events, context),*/
//       ),
//     );
//   }
//
//   void _onDaySelected(DateTime day, List events, BuildContext context) {
//     BlocProvider.of<ScheduleBloc>(context)
//       ..add(GetScheduleDayEvent(
//           selectDay: day,
//           allSchedulesSchoolMap: this.widget.state.allSchedulesSchoolMap,
//           allSchedulePersonalMap: this.widget.state.allSchedulePersonalMap));
//   }
// }
