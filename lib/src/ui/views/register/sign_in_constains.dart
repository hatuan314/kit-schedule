import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';

class SignInConstains {
  static String loginTxt='Login';
  static String welcomeTxt="Welcome to";
  static String kitScheduleTxt="Kit Schedule";
  static String accountTxt="Account";
  static String passwordTxt="Password";
  static Color colorDefault = Colors.blue[800]!;
  static double horizontalScreen = 20.w;
  static TextStyle textStyleTextField =
      TextStyle(color: Colors.blue[800], fontFamily: "MR");
  static TextStyle textStyleTxt = TextStyle(
      color: Colors.black, fontFamily: "MR", fontWeight: FontWeight.w400);
  static double heightLineLogin=2.5.h;
  static double widthLineLogin=30.w;
  static double sizeWelcomeTxt = 40.sp;
  static double sizeIconKit=30.h;
  static double sizeLoginTxt=16.sp;
  static double sizeKitScheduleTxt = 30.sp;
  static double sizeLabelText = 18.sp;
  static double heightLoginBtn = 57.h;
  static double widthLoginBtn = 85.w;
  static double paddingTextToTextFiled = 65.h;
  static double paddingEnd = 90.h;
  static double sizeIconContinue = 40.sp;
  static double heightBottomBar = 60.h;
}
