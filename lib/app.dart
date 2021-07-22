import 'package:flutter/material.dart';
import 'package:schedule/presentation/theme/theme_data.dart';
import 'package:schedule/route.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      onGenerateRoute: router(),
    );
  }
}
