import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:schedule/presentation/themes/theme_border.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/models/model.dart';
import 'package:schedule/presentation/widget/widgets_constants.dart';


class PersonalScheduleElementWidget extends StatelessWidget{
  final PersonalSchedule schedule;

  PersonalScheduleElementWidget({required this.schedule});

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const
        EdgeInsets.symmetric(vertical: WidgetsConstants.cardMargin),
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
                  style: ThemeText.titleStyle2
              ),
            )),
            Expanded(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: WidgetsConstants.detailColumnPaddingHorizontal  ),
                decoration: BoxDecoration(
                    border: Border(
                        left: ThemeBorder.scheduleElementBorder)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '${schedule.name}',
                      style:  ThemeText.titleStyle2,
                    ),
                    Text(
                      '${schedule.note}',
                      style:  ThemeText.titleStyle2.copyWith(fontWeight: FontWeight.normal),
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