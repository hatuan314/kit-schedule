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
      color: AppColor.secondColor,
      fontSize: ScreenUtil().setSp(32),
      fontWeight: FontWeight.w500);

  static TextStyle errorTextStyle = TextStyle(
      color: AppColor.errorColor,
      fontSize: ScreenUtil().setSp(24),
      fontWeight: FontWeight.w500);
}
