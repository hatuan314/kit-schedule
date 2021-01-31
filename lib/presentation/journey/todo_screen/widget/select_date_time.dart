import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/presentation/journey/todo_screen/widget/date_time_field.dart';

class SelectDateTime extends StatelessWidget {
  final String dateTime;
  final ValueChanged<DateTime> onDateTimeChanged;
  final CupertinoDatePickerMode mode;
  final Widget widget;

  const SelectDateTime(
      {Key key,
      @required this.dateTime,
      @required this.onDateTimeChanged,
      @required this.widget,
      @required this.mode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (_) => SizedBox(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            width: double.infinity,
            child: CupertinoDatePicker(
              backgroundColor: ThemeColor.secondColor,
              use24hFormat: true,
              mode: mode,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: onDateTimeChanged,
            ),
          ),
        );
      },
      child: DateTimeField(widget: widget, dateTime: dateTime),
    );
  }
}
