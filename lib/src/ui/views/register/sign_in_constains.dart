import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';

class SignInConstains {
  static double sizeLoginTxt = ScUtil.getInstance().setSp(25);
  static TextStyle textStyleTextField =
      TextStyle(color: Colors.blue[800], fontFamily: "MR");
  static TextStyle textStyleTxt = TextStyle(
      color: Colors.black,
      fontFamily: "MR",
      fontSize: ScUtil.getInstance().setSp(70),
      fontWeight: FontWeight.w400);
  static double sizeWelcomeTxt = ScUtil.getInstance().setSp(70);
  static double sizeKitScheduleTxt = ScUtil.getInstance().setSp(60);
}
