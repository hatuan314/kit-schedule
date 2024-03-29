import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/presentation/themes/theme_border.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isShowed;
  final bool isPassword;
  final bool isInLogInScreen;

  TextFormFieldWidget(
      {required this.controller,
      required this.labelText,
      required this.isShowed,
      required this.isPassword,
      required this.isInLogInScreen});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: labelText == 'Note' ? 5 : 1,
      controller: controller,
      style:
          ThemeText.titleStyle.copyWith(color: AppColor.personalScheduleColor),
      cursorColor: AppColor.textFieldColor,
      obscureText: isPassword ? (!isShowed) : false,
      decoration: InputDecoration(
          errorStyle: ThemeText.errorTextStyle,
          errorMaxLines: 2,
          labelText: labelText,
          labelStyle: ThemeText.labelStyle,
          prefixIcon: Visibility(
              visible: isInLogInScreen,
              child: Icon(isPassword ? Icons.lock : Icons.account_circle,
                  color: AppColor.textFieldColor)),
          enabledBorder: OutlineInputBorder(
              borderSide: ThemeBorder.textFieldEnableBorder,
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          errorBorder: OutlineInputBorder(
              borderSide: ThemeBorder.textFieldErrorBorder,
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: ThemeBorder.textFieldEnableBorder,
              borderRadius: BorderRadius.all(Radius.circular(8.0)))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Trường này không được bỏ trống";
        }
        return null;
      },
    );
  }
}
