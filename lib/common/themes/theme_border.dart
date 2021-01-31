import 'package:flutter/material.dart';
import 'package:schedule/common/themes/theme_color.dart';

class ThemBorder {
  static const BorderRadius borderRadiusAll = BorderRadius.all(Radius.circular(12));
  static  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: borderRadiusAll,
    borderSide: BorderSide(color: ThemeColor.primaryColor),
  );

}