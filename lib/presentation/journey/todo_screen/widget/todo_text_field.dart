import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/app_constance.dart';
import 'package:schedule/common/themes/theme_border.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/presentation/journey/todo_screen/todo_screen_constance.dart';

class TodoTextField extends StatelessWidget {
  final Widget widget;
  final TextEditingController controller;
  final String hintText;
  final int maxLine;
  final TextInputAction textInputAction;
  final Function onEditingComplete;
  final bool autofocus;
  final Function(String) validate;

  const TodoTextField({Key key,
    @required this.widget,
    @required this.controller,
    @required this.hintText,
    this.autofocus,
    this.onEditingComplete,
    this.textInputAction,
    this.maxLine,
    this.validate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget,
        SizedBox(
          width: TodoScreenConstance.spaceSizeBox1,
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: ThemeText.textStyle,
                border: ThemBorder.outlineInputBorder),
            autofocus: autofocus,
            textInputAction:textInputAction,
            onEditingComplete: onEditingComplete,
            maxLines: maxLine,
            validator: validate,
          ),
        )
      ],
    );
  }
}
