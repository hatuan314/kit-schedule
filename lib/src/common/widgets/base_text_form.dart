import 'package:flutter/material.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';

class BaseTextForm extends TextFormField {
  final TextEditingController controller;
  final String labelText;
  final IconData iconData;
  final bool obscureText;

  BaseTextForm(
      {this.controller, this.labelText, this.iconData, this.obscureText})
      : super(
            controller: controller,
            obscureText: obscureText ?? false,
            style: TextStyle(
                color: Colors.blue[800],
                fontSize: ScUtil.getInstance().setSp(32),
                fontFamily: "MR"),
            cursorColor: Colors.blue[800],
            decoration: InputDecoration(
                errorStyle: ThemeText.errorTextStyle,
                errorMaxLines: 2,
                labelText: '$labelText',
                labelStyle: ThemeText.textStyle,
                prefixIcon: Icon(iconData, color: Colors.blue[800]),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue[800],
                        width: ScUtil.getInstance().setWidth(3)),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.redAccent,
                        width: ScUtil.getInstance().setWidth(3)),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue[800],
                        width: ScUtil.getInstance().setWidth(3)),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                )
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field is empty";
              }
              return null;
            });
}

class LoginTextField extends TextFormField {
  final String labelText;
  final IconData iconData;
  final bool obscureText;
 // final TextStyle height;

  LoginTextField(
      { this.labelText, this.iconData, this.obscureText})
      : super(
      obscureText: obscureText ?? false,
      style: TextStyle(
          color: Colors.white,
          fontSize:13,
          fontFamily: "MR"),
      cursorColor: Colors.white,

      decoration: InputDecoration(
          // errorMaxLines: 2,
          labelStyle: ThemeText.textStyle,
          prefixIcon: Icon(iconData, color: Colors.white),
          fillColor: Colors.grey.withAlpha(90),
          filled: true,
           enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))
           ),
           focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field is empty";
        }
        return null;
      });
}

