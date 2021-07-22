import 'package:flutter/material.dart';
import 'package:schedule/common/themes/theme_color.dart';

ThemeData defaultThemeData() {
  return ThemeData(
      fontFamily: "MR",
      primaryColor: AppColor.primaryColor,
      scaffoldBackgroundColor: AppColor.primaryColor,
      errorColor: AppColor.errorColor,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11),
        ),
      ));
}
