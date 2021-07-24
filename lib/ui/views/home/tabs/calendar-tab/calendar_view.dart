// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// import '../../../../../blocs/blocs.dart';
// import '../../../../../utils/convert.dart';
// import '../../../../../utils/utils.dart';
//
// class CalendarView extends StatefulWidget {
//   final CalendarLoadDataSuccessState state;
//
//   const CalendarView({required Key key, this.state}) : super(key: key);
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
// //          markersPositionBottom: ScUtil.getInstance().setHeight(20),
//             outsideDaysVisible: true,
//             weekendStyle: TextStyle(color: Colors.redAccent),
//             selectedStyle: TextStyle(color: Colors.white),
//             todayStyle: TextStyle(color: Colors.white)),
//         headerStyle: HeaderStyle(
//           titleTextStyle: TextStyle(
//               fontSize: ScUtil.getInstance().setSp(32),
//               fontSize: ScreenUtil().setSp(32),
//               fontFamily: 'MR',
//               fontWeight: FontWeight.w500),
//           formatButtonVisible: false,
//           centerHeaderTitle: true,
//           leftChevronIcon: Icon(
//             Icons.arrow_back_ios,
//             size: ScUtil.getInstance().setHeight(18),
//           ),
//           rightChevronIcon: Icon(
//             Icons.arrow_forward_ios,
//             size: ScUtil.getInstance().setHeight(18),
//             size: ScreenUtil().setHeight(18),
//           ),
//           rightChevronIcon: Icon(
//             Icons.arrow_forward_ios,
//             size: ScreenUtil().setHeight(18),
//           ),
//         ),
//         // onDaySelected: (selectDay, events) { _onDaySelected(selectDay, events, context);},
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
