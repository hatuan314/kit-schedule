import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/presentation/journey/home_screen/home_screen_constance.dart';

class ThemeText {
  static TextStyle loginStyle = TextStyle(
      color: ThemeColor.primaryColor,
      fontSize: ScreenUtil().setSp(34),
      fontWeight: FontWeight.w500);
  static TextStyle buttonStyle = TextStyle(
      color: ThemeColor.secondColor,
      fontSize: ScreenUtil().setSp(34),
      fontWeight: FontWeight.w500);

  static TextStyle textStyle = TextStyle(
      color: ThemeColor.primaryColor,
      fontSize: ScreenUtil().setSp(18),
      fontWeight: FontWeight.w500);

  static TextStyle textInforStyle = TextStyle(
      color: ThemeColor.primaryColor,
      fontSize: ScreenUtil().setSp(11),
      fontWeight: FontWeight.w600);

  static TextStyle titleStyle =  TextStyle(
      color: ThemeColor.secondColor,
      fontSize: ScreenUtil().setSp(24),
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

  static TextTheme getDefaultTextTheme = TextTheme(
    // headline3: TextStyle(
    //     fontSize: 50.sp,
    //     fontWeight: FontWeight.w900,
    //     color: AppColor.white),
    // headline2: TextStyle(
    //     fontSize: 60.sp,
    //     fontWeight: FontWeight.w900,
    //     color: AppColor.white),
    // headline5: TextStyle(
    //     fontSize: 22.sp,
    //     fontWeight: FontWeight.w900,
    //     color: AppColor.white),
    // subtitle1: TextStyle(
    //     fontSize: 18.sp,
    //     fontWeight: FontWeight.normal,
    //     color: AppColor.white),
    // bodyText1: TextStyle(
    //     fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColor.navy),
    // bodyText2: TextStyle(
    //     fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColor.navy),
    button: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: ThemeColor.primaryColor),
    // caption: TextStyle(
    //     fontSize: 12.sp,
    //     fontWeight: FontWeight.normal,
    //     color: AppColor.grey),
  );
}
