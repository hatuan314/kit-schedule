import 'package:flutter/material.dart';
import 'package:schedule/route.dart';
import 'package:schedule/src/common/themes/theme_data.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: defaultThemeData(),
      onGenerateRoute: router(),
    );
  }
}
