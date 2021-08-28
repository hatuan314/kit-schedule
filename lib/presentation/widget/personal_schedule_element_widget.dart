import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/domain/entities/personal_schedule_entities.dart';

import 'package:schedule/presentation/themes/theme_border.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/models/model.dart';
import 'package:schedule/presentation/widget/widgets_constants.dart';


class PersonalScheduleElementWidget extends StatelessWidget{
  final PersonalScheduleEntities schedule;

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
                  style: ThemeText.textStyle.copyWith(color: AppColor.signInColor)
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
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style:  ThemeText.textStyle.copyWith(color: AppColor.signInColor),
                    ),
                    Text(
                      schedule.note==null?'':schedule.note as String,
                      style:  ThemeText.textStyle.copyWith(fontWeight: FontWeight.normal, color: AppColor.signInColor),
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
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