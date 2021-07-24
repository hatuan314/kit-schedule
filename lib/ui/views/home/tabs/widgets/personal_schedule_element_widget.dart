import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/themes/theme_border.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/models/model.dart';


class PersonalScheduleElementWidget extends StatelessWidget{
  final PersonalSchedule schedule;

  PersonalScheduleElementWidget({required this.schedule});

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding:
        EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '${schedule.timer}',
                  style: ThemeText.titleStyle
              ),
            )),
            Expanded(
              flex: 8,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(20)),
                decoration: BoxDecoration(
                    border: Border(
                        left: ThemeBorder.scheduleElementBorder)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '${schedule.name}',
                      style:  ThemeText.titleStyle,
                    ),
                    Text(
                      '${schedule.note}',
                      style:  ThemeText.titleStyle.copyWith(fontWeight: FontWeight.normal),
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }



}