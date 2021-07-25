import 'package:flutter/material.dart';
import 'package:schedule/common/themes/theme_color.dart';

import 'theme_border.dart';

ThemeData defaultThemeData() {
  return ThemeData(
      fontFamily: "MR",
      primaryColor: AppColor.primaryColor,
      scaffoldBackgroundColor: AppColor.primaryColor,
      errorColor: AppColor.errorColor,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: ThemeBorder.borderRadiusAll,
        ),
      ));
}
