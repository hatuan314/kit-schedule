import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';

class TodoTextField extends StatelessWidget {
  final Widget widget;
  final TextEditingController controller;
  final String hintText;
  final int maxLine;
  final Function(String) validate;

  const TodoTextField(
      {Key key,
      @required this.widget,
      @required this.controller,
      @required this.hintText,
      this.maxLine,
      this.validate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget,
        SizedBox(
          width: ScreenUtil().setWidth(20),
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: ThemeText.textStyle,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: ThemeColor.primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                )),
            maxLines: maxLine,
            validator: validate,
          ),
        )
      ],
    );
  }
}
