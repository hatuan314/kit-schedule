import 'package:flutter/material.dart';
import 'package:schedule/presentation/theme/theme_colors.dart';

ButtonThemeData buttonTheme = ButtonThemeData(
  buttonColor: AppColor.primaryColor,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  disabledColor: AppColor.disableButtonColor,
  splashColor: AppColor.transparent,
);