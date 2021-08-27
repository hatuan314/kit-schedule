import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedule/presentation/journey/todo_screen/bloc/todo_bloc.dart';
import 'package:schedule/presentation/journey/todo_screen/todo_constants.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/presentation/widget/spacing_box_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetTimeWidget extends StatelessWidget {
  final TodoState state;
  final String title;
  final bool isDate;
  final Function() onTap;
  const SetTimeWidget(
      {Key? key,
      required this.state,
      required this.title,
      this.isDate = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: ThemeText.titleStyle.copyWith(fontSize: 18.sp)),
          SpacingBoxWidget(height: 10),
          InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                      color: AppColor.personalScheduleColor, width: 0.5)),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  vertical: ToDoConstants.setTimeContainerPaddingVertical),
              child: Text(
                isDate
                    ? state.selectDay != null
                        ? '${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(int.parse(state.selectDay!)))}'
                        : ''
                    : state.selectTimer != null
                        ? '${state.selectTimer}'
                        : '',
                style: ThemeText.labelStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: ToDoConstants.timeFontSize),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
