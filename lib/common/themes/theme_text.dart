import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/src/utils/utils.dart';

class ThemeText {
/*  static TextStyle loginStyle = TextStyle(
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
      fontWeight: FontWeight.w600);*/

/*  static TextStyle titleStyle =  TextStyle(
      color: ThemeColor.secondColor,
      fontSize: ScreenUtil().setSp(24),
      fontWeight: FontWeight.w500);*/
  static TextStyle titleStyle=  TextStyle(
      fontSize: ScUtil.getInstance()!.setSp(32),
      color: ThemeColor.personalScheduleColor,
      fontFamily: 'MR',
      fontWeight: FontWeight.w600 );

  static TextStyle numberStyle = TextStyle(
      fontSize: ScUtil.getInstance()!.setSp(28),
      color: ThemeColor.secondColor,
      fontWeight: FontWeight.normal);

  static TextStyle headerStyle = TextStyle(
      fontSize: ScUtil.getInstance()!.setSp(42),
      color: ThemeColor.secondColor,
      fontFamily: 'MR',
      fontWeight: FontWeight.w600);

  static TextStyle headerStyle2 = TextStyle(
  fontSize: ScUtil.getInstance()!.setSp(40),
  color: ThemeColor.signInColor,
  fontFamily: 'MR',
  fontWeight: FontWeight.w600);

  static TextStyle textInforStyle = TextStyle(
      color: ThemeColor.secondColor,
      fontSize: ScreenUtil().setSp(28),
      fontWeight: FontWeight.normal);

  static TextStyle errorTextStyle=TextStyle(
  fontSize: ScUtil.getInstance()!.setSp(24),
  color:ThemeColor.errorColor2,
  fontFamily: "MR");

  static TextStyle labelStyle = TextStyle(
      fontSize: ScUtil.getInstance()!.setSp(32),
      color: ThemeColor.personalScheduleColor,
      fontWeight: FontWeight.w500,
      fontFamily: "MR");

  /*static TextStyle errorTextStyle = TextStyle(
      color: ThemeColor.errorColor,
      fontSize: ScreenUtil().setSp(24),
      fontWeight: FontWeight.w500);

  static TextStyle menuItemTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
    //  fontSize: HomeScreenConstance.menuItemTextSize,
      color: ThemeColor.menuItemTextColor);
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
        color: ThemeColor.primaryColor),
    // caption: TextStyle(
    //     fontSize: 12.sp,
    //     fontWeight: FontWeight.normal,
    //     color: AppColor.grey),
  );
}