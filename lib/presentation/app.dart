import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/router_list.dart';
import 'package:schedule/common/themes/theme_data.dart';
import 'package:schedule/injection.dart';
import 'package:schedule/presentation/screen/home_screen/home_bloc/home_bloc.dart';
import 'package:schedule/presentation/screen/home_screen/home_screen.dart';
import 'package:schedule/presentation/screen/search_screen/bloc/search_bloc.dart';
import 'package:schedule/presentation/screen/search_screen/bloc/search_event.dart';
import 'package:schedule/presentation/screen/search_screen/search_screen.dart';
import 'package:schedule/presentation/screen/todo_screen/bloc/todo_bloc.dart';
import 'package:schedule/presentation/screen/todo_screen/bloc/todo_event.dart';
import 'package:schedule/presentation/screen/todo_screen/todo_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 667),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: defaultThemeData(),
          initialRoute: RouterList.home,
          routes: {
            RouterList.home: (context) => BlocProvider<HomeBloc>(
                  create: (_) => getIt<HomeBloc>(),
                  child: HomeScreen(),
                ),
            RouterList.todo: (context) => BlocProvider<TodoBloc>(
                  create: (_) => getIt<TodoBloc>()..add(TodoInitEvent()),
                  child: TodoScreen(),
                ),
            RouterList.search: (context) => BlocProvider<SearchBloc>(
                create: (_) => getIt<SearchBloc>()..add(SearchInitEvent()),
            child: SearchScreen(),),
          },
        ));
  }
}
