import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/common/themes/theme_border.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/src/models/model.dart';
import 'package:schedule/src/utils/convert.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';


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
        EdgeInsets.symmetric(vertical: ScUtil.getInstance()!.setHeight(8)),
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
                      style: ThemeText.titleStyle.copyWith(color: ThemeColor.scheduleType)),
                    Icon(Icons.arrow_drop_down,
                        color: ThemeColor.scheduleType,
                        size: ScUtil.getInstance()!.setHeight(15)),
                    Text(
                      '${Convert.endTimeLessonMap[endLesson]}',
                      style: ThemeText.titleStyle.copyWith(color: ThemeColor.scheduleType)),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ScUtil.getInstance()!.setWidth(20)),
                decoration: BoxDecoration(
                    border: Border(
                        left: ThemeBorder.scheduleElementBorder.copyWith(color: ThemeColor.scheduleType))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '${schedule.subject}',
                      style: ThemeText.titleStyle.copyWith(color: ThemeColor.scheduleType)),
                    Text(
                      schedule.address!.contains('null')
                          ? 'No Data'
                          : '${schedule.address}',
                      style: ThemeText.titleStyle.copyWith(color: ThemeColor.scheduleType).copyWith(fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }



}