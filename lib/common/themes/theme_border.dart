import 'package:flutter/material.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeBorder {
  static const BorderRadius borderRadiusAll = BorderRadius.all(Radius.circular(12));
  static  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: borderRadiusAll,
    borderSide: BorderSide(color: ThemeColor.primaryColor),
  );
  static const Color borderColor = Color(0xFF42A5F5);
  static double borderWidth = 5.w;

}