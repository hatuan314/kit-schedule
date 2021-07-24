import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/themes/theme_border.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/models/model.dart';
import 'package:schedule/utils/convert.dart'; 


class SchoolScheduleElementWidget extends StatelessWidget{
  final SchoolSchedule schedule;


  SchoolScheduleElementWidget({required this.schedule});

  @override
  Widget build(BuildContext context) {

      List lessonNumbers = schedule.lesson!.split(',');
      String startLesson = lessonNumbers[0];
      String endLesson = lessonNumbers[lessonNumbers.length - 1];
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '${Convert.startTimeLessonMap[startLesson]}',
                      style: ThemeText.titleStyle.copyWith(color: AppColor.scheduleType)),
                    Icon(Icons.arrow_drop_down,
                        color: AppColor.scheduleType,
                        size: ScreenUtil().setHeight(15)),
                    Text(
                      '${Convert.endTimeLessonMap[endLesson]}',
                      style: ThemeText.titleStyle.copyWith(color: AppColor.scheduleType)),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(20)),
                decoration: BoxDecoration(
                    border: Border(
                        left: ThemeBorder.scheduleElementBorder.copyWith(color: AppColor.scheduleType))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '${schedule.subject}',
                      style: ThemeText.titleStyle.copyWith(color: AppColor.scheduleType)),
                    Text(
                      schedule.address!.contains('null')
                          ? 'No Data'
                          : '${schedule.address}',
                      style: ThemeText.titleStyle.copyWith(color: AppColor.scheduleType).copyWith(fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }



}