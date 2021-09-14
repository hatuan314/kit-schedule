import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/blocs/blocs.dart';
import 'package:schedule/common/injector/injector.dart';
import 'package:schedule/common/utils/convert.dart';
import 'package:schedule/presentation/journey/home/calendar_tab_constants.dart';
import 'package:schedule/presentation/journey/home/schedule_widget.dart';
import 'package:schedule/presentation/widget/loading_widget/loading_widget.dart';

import 'calendar_widget.dart';

class CalendarTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        if (state is CalendarLoadingDataState)
          return Scaffold(
            backgroundColor: CalendarTabConstants.backgroundColor,
            body: Center(
              child: Container(
                margin: const EdgeInsets.only(
                    top: CalendarTabConstants.marginLoading),
                child: LoadingWidget(),
              ),
            ),
          );
        else if (state is CalendarLoadDataSuccessState) {
          return Scaffold(
              backgroundColor: CalendarTabConstants.backgroundColor,
              body: BlocProvider(
                create: (context) => Injector.getIt<ScheduleBloc>()
                  ..add(GetScheduleDayEvent(
                      selectDay: Convert.dateConvert(DateTime.now()),
                      allSchedulesSchoolMap: state.allSchedulesSchoolMap,
                      allSchedulePersonalMap: state.allSchedulePersonalMap)),
                child: _mBody(context, state),
              ));
        } else
          return Scaffold(
            backgroundColor: CalendarTabConstants.backgroundColor,
            body: SizedBox(),
          );
      },
    );
  }

  _mBody(BuildContext context, CalendarLoadDataSuccessState state) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          CalendarView(state: state),
          Expanded(child: ScheduleWidget()),
        ],
      ),
    );
  }
}
