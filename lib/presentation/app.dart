import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/router_list.dart';
import 'package:schedule/common/themes/theme_data.dart';
import 'package:schedule/injection.dart';
import 'package:schedule/presentation/route.dart';
import 'package:schedule/presentation/screen/home_screen/home_bloc/home_bloc.dart';
import 'package:schedule/presentation/screen/home_screen/home_screen.dart';
import 'package:schedule/presentation/screen/todo_screen/todo_screen.dart';
import 'package:schedule/src/ui/views/register/infor.dart';
import 'package:schedule/src/ui/views/register/login_screen.dart';
import 'package:schedule/src/ui/views/register/sign_in_view.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375,667),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: defaultThemeData(),
            initialRoute: RouterList.home,
            routes: {
              RouterList.home: (context) => BlocProvider<HomeBloc>(
                create: (_) => getIt<HomeBloc>(),
                   child: LoginScreen(),
        ),
            RouterList.todo:  (context) =>   TodoScreen()


      },
    ));
  }
}
