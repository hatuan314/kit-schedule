import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/themes/theme_color.dart';

class ThemeBorder {
  static const BorderRadius borderRadiusAll = BorderRadius.all(Radius.circular(12));
  static  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: borderRadiusAll,
    borderSide: BorderSide(color: AppColor.primaryColor),
  );
  static const Color borderColor = Color(0xFF42A5F5);

  static double borderWidth = 5.w;

  static BorderSide scheduleElementBorder= BorderSide(
  width: ScreenUtil() .setWidth(1.2),
  color: AppColor.personalScheduleColor);

  static BorderSide textFieldEnableBorder = BorderSide(
      color: AppColor.personalScheduleColor,
      width: ScreenUtil() .setWidth(3));

  static BorderSide textFieldErrorBorder = BorderSide(
      color: AppColor.errorColor,
      width: ScreenUtil() .setWidth(3));
  static OutlineInputBorder textFieldBorder= OutlineInputBorder(
  borderSide: BorderSide(
      color: AppColor.errorColor,
      width: ScreenUtil() .setWidth(3)),
  borderRadius: BorderRadius.all(Radius.circular(8.0)));
}
