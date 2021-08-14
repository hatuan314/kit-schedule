import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:schedule/common/constants/layout_constants.dart';
import 'package:schedule/presentation/journey/todo_screen/bloc/todo_bloc.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../todo_constants.dart';
class TodoBackgroundWidget extends StatelessWidget {
  final TodoState state;
  final Function() selectDataPicker;
  final String header;
  const TodoBackgroundWidget({Key? key,required this.state,required this.selectDataPicker,required this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: LayoutConstants.paddingHorizontal),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Text(
                  header,
                  style: ThemeText.headerStyle,
                ),
              ),
              InkWell(
                onTap: selectDataPicker,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ToDoConstants.inkWellPaddingVertical),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SvgPicture.asset(
                        ToDoConstants.calendarImgPath,
                        color: AppColor.secondColor,
                        height: ToDoConstants.calendarImgHeight,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                          state.selectDay != null
                              ? '${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(int.parse(state.selectDay!)))}'
                              : '',
                          style: ThemeText.textInforStyle),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: LayoutConstants.paddingHorizontal),
            child: SvgPicture.asset(
              ToDoConstants.kitLogoPath,
              width: ToDoConstants.kitLogoWidth,
            ),
          )
        ],
      ),
    );
  }
}
