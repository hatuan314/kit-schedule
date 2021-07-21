import 'package:flutter/material.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';

import 'theme_border.dart';

ThemeData defaultThemeData() {
  return ThemeData(
      fontFamily: "MR",
      primaryColor: ThemeColor.primaryColor,
      scaffoldBackgroundColor: ThemeColor.primaryColor,
      errorColor: ThemeColor.errorColor,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: ThemeBorder.borderRadiusAll,
        ),
      ));
}