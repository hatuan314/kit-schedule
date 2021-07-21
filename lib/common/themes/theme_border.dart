import 'package:flutter/material.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';

class ThemeBorder {
  static const BorderRadius borderRadiusAll = BorderRadius.all(Radius.circular(12));
  static  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: borderRadiusAll,
    borderSide: BorderSide(color: ThemeColor.primaryColor),
  );
  static const Color borderColor = Color(0xFF42A5F5);

  static double borderWidth = 5.w;

  static BorderSide scheduleElementBorder= BorderSide(
  width: ScUtil.getInstance()!.setWidth(1.2),
  color: ThemeColor.personalScheduleColor);

  static BorderSide textFieldEnableBorder = BorderSide(
      color: ThemeColor.personalScheduleColor,
      width: ScUtil.getInstance()!.setWidth(3));

  static BorderSide textFieldErrorBorder = BorderSide(
      color: ThemeColor.errorColor,
      width: ScUtil.getInstance()!.setWidth(3));
  static OutlineInputBorder textFieldBorder= OutlineInputBorder(
  borderSide: BorderSide(
      color: ThemeColor.errorColor,
      width: ScUtil.getInstance()!.setWidth(3)),
  borderRadius: BorderRadius.all(Radius.circular(8.0)));
}