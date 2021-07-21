
import 'package:flutter/material.dart';

import 'package:schedule/src/ui/views/register/sign_in_constains.dart';

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
                errorMaxLines: 2,
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
                    borderRadius: BorderRadius.all(Radius.circular(8.0)))),
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
  final Function showPassWordBtn;
  final TextEditingController textController;
  // final TextStyle height;

  LoginTextField(
      {this.labelText,
      this.iconData,
      this.obscureText,
      this.textController,
      this.showPassWordBtn})
      : super(
            controller: textController,
            obscureText: obscureText ?? false,
            style: SignInConstains.textStyleTextField
                .copyWith(fontSize: ScUtil.getInstance().setSp(30)),
            cursorColor:  Colors.blue[800],
            decoration: InputDecoration(
                // errorMaxLines: 2,
                fillColor: Colors.transparent,
                labelText: labelText,
                suffixIcon: obscureText != null
                    ? IconButton(
                        onPressed: showPassWordBtn,
                        icon: Icon(
                          true ? Icons.visibility_off : Icons.visibility,
                          color: Colors.blue[800],
                        ),
                      )
                    : SizedBox(),
                labelStyle: SignInConstains.textStyleTextField
                    .copyWith(fontSize: ScUtil.getInstance().setSp(30)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[800]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[800]),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color:  Colors.blue[800]),
                ),
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Trường này không được bỏ trống";
              }
              return null;
            });
}
