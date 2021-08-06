import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';

class ThemeText {
  static TextStyle buttonStyle = TextStyle(
      color: AppColor.secondColor,
      fontSize: ScreenUtil().setSp(18),
      fontWeight: FontWeight.w500);

  static TextStyle textStyle = TextStyle(
      color: AppColor.primaryColor,
      fontSize: ScreenUtil().setSp(14),
      fontWeight: FontWeight.w500);

  static TextStyle titleStyle = TextStyle(
      fontSize: ScreenUtil().setSp(22),
      color: AppColor.personalScheduleColor,
      fontFamily: 'MR',
      fontWeight: FontWeight.w600);

  static TextStyle titleStyle2 = TextStyle(
      fontSize: ScreenUtil().setSp(20),
      color: AppColor.personalScheduleColor,
      fontFamily: 'MR',
      fontWeight: FontWeight.w600);

  static TextStyle errorTextStyle = TextStyle(
      fontSize: ScreenUtil().setSp(14),
      color: AppColor.errorColor2,
      fontFamily: "MR");

  static TextStyle numberStyle = TextStyle(
      fontSize: ScreenUtil().setSp(18),
      color: AppColor.secondColor,
      fontWeight: FontWeight.normal);

  static TextStyle headerStyle = TextStyle(
      fontSize: ScreenUtil().setSp(25),
      color: AppColor.secondColor,
      fontFamily: 'MR',
      fontWeight: FontWeight.w600);

  static TextStyle headerStyle2 = TextStyle(
      fontSize: ScreenUtil().setSp(25),
      color: AppColor.signInColor,
      fontFamily: 'MR',
      fontWeight: FontWeight.w600);

  static TextStyle textInforStyle = TextStyle(
      fontFamily: 'MR',
      color: AppColor.secondColor,
      fontSize: ScreenUtil().setSp(18),
      fontWeight: FontWeight.normal);

  static TextStyle labelStyle = TextStyle(
      fontSize: ScreenUtil().setSp(18),
      color: AppColor.personalScheduleColor,
      fontWeight: FontWeight.w500,
      fontFamily: "MR");

  static TextStyle buttonLabelStyle = TextStyle(
      color: Color(0xffFCFAF3),
      fontSize: ScreenUtil().setSp(18),
      fontFamily: 'MR',
      fontWeight: FontWeight.w600);

  static TextStyle dayOfWeekStyle=TextStyle(fontFamily: 'MR', fontWeight: FontWeight.w400);

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
  TextStyle welcomeTextStyle = TextStyle(
      letterSpacing: 5.w,
      fontSize: 20.sp,
//        fontWeight: FontWeight.w300,
      fontFamily: 'MR',
      color: AppColor.signInColor);

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
