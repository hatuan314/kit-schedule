import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/themes/theme_data.dart';
import 'package:schedule/presentation/route.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(1080,1920),
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: defaultThemeData(),
      onGenerateRoute: router(),
    ));
  }
}
