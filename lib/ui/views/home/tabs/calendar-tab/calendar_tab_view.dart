import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/blocs/blocs.dart';
import 'package:schedule/ui/views/home/tabs/calendar-tab/schedule_view.dart';
import 'package:schedule/utils/utils.dart';

class CalendarTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        if (state is CalendarLoadingDataState)
          return Scaffold(
            backgroundColor: Color(0xffFCFAF3),
            body: Center(
              child: Container(
                margin:
                    EdgeInsets.only(top: ScreenUtil().setHeight(50)),
                child: LoadingWidget(
                  color: Colors.blue,
                  size: 40.0,
                ),
              ),
            ),
          );
        else if (state is CalendarLoadDataSuccessState) {
          return Scaffold(
              backgroundColor: Color(0xffFCFAF3),
              body: BlocProvider(
                create: (context) => ScheduleBloc()
                  ..add(GetScheduleDayEvent(
                      selectDay: Convert.dateConvert(DateTime.now()),
                      allSchedulesSchoolMap: state.allSchedulesSchoolMap,
                      allSchedulePersonalMap: state.allSchedulePersonalMap)),
                child: _mBody(context, state),
              ));
        } else
          return Scaffold(
            backgroundColor: Color(0xffFCFAF3),
            body: SizedBox(),
          );
      },
    );
  }

  _mBody(BuildContext context, CalendarLoadDataSuccessState state) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          //CalendarView(state: state),
          Expanded(child: ScheduleView()),
        ],
      ),
    );
  }
}
