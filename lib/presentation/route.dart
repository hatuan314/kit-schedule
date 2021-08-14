import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/blocs/blocs.dart';
import 'package:schedule/blocs/search/search_bloc.dart';
import 'package:schedule/common/injector/injector.dart';
import 'package:schedule/models/model.dart';
import 'package:schedule/presentation/journey/sign_in_screen.dart/bloc/register_bloc.dart';
import 'package:schedule/presentation/journey/sign_in_screen.dart/sign_in_view.dart';
import 'package:schedule/presentation/journey/splash/splash_view.dart';
import 'package:schedule/presentation/journey/main/main_screen.dart';
import 'package:schedule/presentation/journey/todo_screen/bloc/todo_bloc.dart';

import 'package:schedule/presentation/journey/todo_screen/todo_detail_screen.dart';
import 'package:schedule/presentation/journey/todo_screen/todo_screen.dart';

int currentRoot = 1;

RouteFactory router() {
  return (RouteSettings settings) {
    if (currentRoot == 1) {
      currentRoot = 2;
      return CupertinoPageRoute(builder: (context) {
        return SplashView();
      });
    }

    // final args = settings.arguments as Map<String, dynamic> ?? {};

    // todo:  add screen route here
    switch (settings.name) {
      case '/sign-in':
        return CupertinoPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) => Injector.getIt<RegisterBloc>(),
            child: SignInView(),
          );
        });
      case '/home':
        return CupertinoPageRoute(builder: (context) {
          return MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => HomeBloc(),
            ),
            BlocProvider(
              create: (context) => Injector.getIt<CalendarBloc>()
                ..add(GetAllScheduleDataEvent()),
            ),
            BlocProvider(
              create: (context) =>
                  SearchBloc()..add(SearchButtonOnPress(DateTime.now())),
            ),
            BlocProvider(
              create: (context) => Injector.getIt<TodoBloc>(),
            ),
          ], child: MainScreen());
//            child: SchoolSchedulePageView());
        });
      case '/todo-detail':
        PersonalSchedule schedule = PersonalSchedule.fromJson(
            settings.arguments as Map<String, dynamic>);
        int hour = int.parse(schedule.timer!.split(':').elementAt(0));
        int minute = int.parse(schedule.timer!.split(':').elementAt(1));
        return CupertinoPageRoute(builder: (context) {
          return BlocProvider(
              create: (context) => Injector.getIt<TodoBloc>()
                ..add(SelectDatePickerOnPressEvent(
                    selectDay: DateTime.fromMillisecondsSinceEpoch(
                        int.parse(schedule.date!))))
                ..add(SelectTimePickerOnPressEvent(
                    timer: TimeOfDay(hour: hour, minute: minute))),
              child: TodoScreen(personalSchedule: schedule));
        });
    }

    return MaterialPageRoute(
      builder: (_) => Container(), //todo must return widget
    );
  };
}
