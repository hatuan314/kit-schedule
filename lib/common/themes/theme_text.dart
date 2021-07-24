import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/themes/theme_color.dart';

class ThemeText {
  static TextStyle buttonStyle = TextStyle(
      color: AppColor.secondColor,
      fontSize: ScreenUtil().setSp(34),
      fontWeight: FontWeight.w500);

  static TextStyle textStyle = TextStyle(
      color: AppColor.primaryColor,
      fontSize: ScreenUtil().setSp(18),
      fontWeight: FontWeight.w500);

  static TextStyle titleStyle = TextStyle(
      fontSize: ScreenUtil().setSp(32),
      color: AppColor.personalScheduleColor,
      fontFamily: 'MR',
      fontWeight: FontWeight.w600);

  static TextStyle errorTextStyle = TextStyle(
      fontSize: ScreenUtil().setSp(24),
      color: AppColor.errorColor2,
      fontFamily: "MR");

  static TextStyle numberStyle = TextStyle(
      fontSize: ScreenUtil().setSp(28),
      color: AppColor.secondColor,
      fontWeight: FontWeight.normal);

  static TextStyle headerStyle = TextStyle(
      fontSize: ScreenUtil().setSp(42),
      color: AppColor.secondColor,
      fontFamily: 'MR',
      fontWeight: FontWeight.w600);

  static TextStyle headerStyle2 = TextStyle(
      fontSize: ScreenUtil().setSp(40),
      color: AppColor.signInColor,
      fontFamily: 'MR',
      fontWeight: FontWeight.w600);

  static TextStyle textInforStyle = TextStyle(
      color: AppColor.secondColor,
      fontSize: ScreenUtil().setSp(32),
      fontWeight: FontWeight.normal);

  static TextStyle labelStyle = TextStyle(
      fontSize: ScreenUtil().setSp(32),
      color: AppColor.personalScheduleColor,
      fontWeight: FontWeight.w500,
      fontFamily: "MR");

  static TextStyle buttonLabelStyle = TextStyle(
      color: Color(0xffFCFAF3),
      fontSize: ScreenUtil().setSp(36),
      fontFamily: 'MR',
      fontWeight: FontWeight.w600);

  /*static TextStyle errorTextStyle = TextStyle(
      color: AppColor.errorColor,
      fontSize: ScreenUtil().setSp(24),
      fontWeight: FontWeight.w500);

  static TextStyle menuItemTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
    //  fontSize: HomeScreenConstance.menuItemTextSize,
      color: AppColor.menuItemTextColor);
  static TextStyle accountTextStyle = TextStyle(
      fontWeight: FontWeight.normal,
   //   fontSize: HomeScreenConstance.menuItemTextSize,
      color: Colors.white);
  static TextStyle dayOfWeekStyle = TextStyle(
      fontWeight: FontWeight.normal,
     // fontSize: HomeScreenConstance.dayOfWeekTextSize,
      color: Colors.red);
*/
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
        color: AppColor.primaryColor),
    // caption: TextStyle(
    //     fontSize: 12.sp,
    //     fontWeight: FontWeight.normal,
    //     color: AppColor.grey),
  );
}
