import 'package:flutter/material.dart';
import 'package:schedule/src/common/themes/theme_color.dart';
import 'package:schedule/src/utils/utils.dart';

class ThemeText {
  static TextStyle buttonStyle = TextStyle(
      color: ThemeColor.secondColor,
      fontSize: ScUtil.getInstance().setSp(34),
      fontWeight: FontWeight.w500);

  static TextStyle textStyle = TextStyle(
      color: ThemeColor.primaryColor,
      fontSize: ScUtil.getInstance().setSp(32),
      fontWeight: FontWeight.w500);

  static TextStyle errorTextStyle = TextStyle(
      color: ThemeColor.errorColor,
      fontSize: ScUtil.getInstance().setSp(24),
      fontWeight: FontWeight.w500);
}
