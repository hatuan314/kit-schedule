import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/common/router_list.dart';
import 'package:schedule/injection.dart';
import 'package:schedule/presentation/journey/home_screen/home_screen.dart';
import 'package:schedule/presentation/journey/todo_screen/todo_screen.dart';
import 'package:schedule/src/blocs/blocs.dart';
import 'package:schedule/src/models/model.dart';
import 'package:schedule/src/ui/views/views.dart';
import 'package:schedule/src/utils/utils.dart';

int currentRoot = 1;

RouteFactory router() {
  return (RouteSettings settings) {
    Widget screen;

    if (currentRoot == 1) {
      currentRoot = 2;
      /*return CupertinoPageRoute(builder: (context) {
        ScUtil.init(context, pWidth: 750, pHeight: 640);
        return SplashView();
      });*/
      CupertinoPageRoute(builder: (context) {
        return BlocProvider<HomeBloc>(
          create: (context) => getIt<HomeBloc>(),
          child: HomeScreen(),
        );
      });
    }

    final args = settings.arguments as Map<String, dynamic> ?? {};

    // todo:  add screen route here
    switch (settings.name) {
      case '/sign-in':
        return CupertinoPageRoute(builder: (context) {
          ScUtil.init(context, pWidth: 750, pHeight: 640);
          return BlocProvider(
            create: (context) => RegisterBloc(),
            child: SignInView(),
          );
        });
      case RouterList.home:
        return CupertinoPageRoute(builder: (context) {
          return BlocProvider<HomeBloc>(
            create: (context) => getIt<HomeBloc>(),
            child: HomeScreen(),
          );
        });
      case RouterList.todo:
        return CupertinoPageRoute(builder: (context) {
          return TodoScreen();
        });
        /*case '/home':
        return CupertinoPageRoute(builder: (context) {
          ScUtil.init(context, pWidth: 750, pHeight: 640);
          return MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => HomeBloc(),
            ),
            BlocProvider(
              create: (context) =>
                  CalendarBloc()..add(GetAllScheduleDataEvent()),
            ),
            BlocProvider(
              create: (context) =>
                  SearchBloc()..add(SearchButtonOnPress(DateTime.now())),
            ),
            BlocProvider(
              create: (context) => TodoBloc(
                  calendarBloc: BlocProvider.of<CalendarBloc>(context)),
            ),
          ], child: HomeView());
//            child: SchoolSchedulePageView());
        });*/
      case '/todo-detail':
        PersonalSchedule schedule =
            PersonalSchedule.fromJson(settings.arguments);
        return CupertinoPageRoute(builder: (context) {
          ScUtil.init(context, pWidth: 750, pHeight: 640);
          return BlocProvider(
              create: (context) => TodoBloc(),
              child: TodoDetailView(schedule: schedule));
        });
//      case HomeView.route:
//        screen = HomeView();
//        break;
    }

    return MaterialPageRoute(
      builder: (_) => screen,
    );
  };
}
