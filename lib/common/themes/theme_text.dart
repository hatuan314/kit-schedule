import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/presentation/screen/home_screen/home_screen_constance.dart';

class ThemeText {
  static TextStyle buttonStyle = TextStyle(
      color: ThemeColor.secondColor,
      fontSize: ScreenUtil().setSp(34),
      fontWeight: FontWeight.w500);

  static TextStyle textStyle = TextStyle(
      color: ThemeColor.primaryColor,
      fontSize: ScreenUtil().setSp(18),
      fontWeight: FontWeight.w500);
  static TextStyle titleStyle =  TextStyle(
      color: ThemeColor.secondColor,
      fontSize: ScreenUtil().setSp(32),
      fontWeight: FontWeight.w500);

  static TextStyle errorTextStyle = TextStyle(
      color: ThemeColor.errorColor,
      fontSize: ScreenUtil().setSp(24),
      fontWeight: FontWeight.w500);

  static TextStyle menuItemTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: HomeScreenConstance.menuItemTextSize,
      color: ThemeColor.menuItemTextColor);
  static TextStyle accountTextStyle = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: HomeScreenConstance.menuItemTextSize,
      color: Colors.white);
  static TextStyle dayOfWeekStyle = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: HomeScreenConstance.dayOfWeekTextSize,
      color: Colors.red);
}
