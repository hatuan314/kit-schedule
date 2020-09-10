import 'package:flutter/material.dart';
import 'package:schedule/src/common/themes/theme_color.dart';

ThemeData defaultThemeData() {
  return ThemeData(
      fontFamily: "MR",
      primaryColor: ThemeColor.primaryColor,
      scaffoldBackgroundColor: ThemeColor.primaryColor,
      errorColor: ThemeColor.errorColor,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11),
        ),
      ));
}
