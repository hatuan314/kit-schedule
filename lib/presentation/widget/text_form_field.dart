
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/presentation/journey/register/sign_in_constants.dart';


class BaseTextForm extends TextFormField {
  final TextEditingController controller;
  final String labelText;
  final IconData iconData;
  final bool? obscureText;

  BaseTextForm(
      {required this.controller,
        required this.labelText,
        required this.iconData,
        this.obscureText})
      : super(
      controller: controller,
      obscureText: obscureText ?? false,
      style: TextStyle(
          color: Colors.blue[800], fontSize: 32.sp, fontFamily: "MR"),
      cursorColor: Colors.blue[800],
      decoration: InputDecoration(
          errorMaxLines: 2,
          prefixIcon: Icon(iconData, color: Colors.blue[800]),
          enabledBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: (Colors.blue[800])!, width: 3.w),
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent, width: 3.w),
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: (Colors.blue[800])!, width: 3.w),
              borderRadius: BorderRadius.all(Radius.circular(8.0)))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field is empty";
        }
        return null;
      });
}

class LoginTextField extends TextFormField {
  final String? labelText;
  final IconData? iconData;
  final bool? obscureText;
  final Function()? showPassWordBtn;
  final TextEditingController? textController;

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
      style: SignInConstants.textStyleTextField
          .copyWith(fontSize: SignInConstants.sizeLabelText),
      cursorColor: SignInConstants.colorDefault,
      decoration: InputDecoration(
        // errorMaxLines: 2,
          fillColor: Colors.transparent,
          labelText: labelText,
          suffixIcon: obscureText != null
              ? IconButton(
            onPressed: showPassWordBtn,
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: SignInConstants.colorDefault,
            ),
          )
              : SizedBox(),
          focusColor: Colors.red,
          labelStyle: SignInConstants.textStyleTextField
              .copyWith(fontSize: SignInConstants.sizeLabelText),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: SignInConstants.colorDefault),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color:SignInConstants.colorDefault),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color:SignInConstants.colorDefault),
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
