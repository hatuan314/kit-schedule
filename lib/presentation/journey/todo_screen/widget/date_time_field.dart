import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/presentation/journey/todo_screen/todo_screen_constance.dart';

class DateTimeField extends StatelessWidget {
  final Widget widget;
  final String dateTime;


  const DateTimeField(
      {Key key, @required this.widget, @required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget,
        SizedBox(width: TodoScreenConstance.spaceSizeBox1,),
        Expanded(
          child: Text(dateTime,style: ThemeText.textStyle,)
        ),
      ],
    );
  }
}