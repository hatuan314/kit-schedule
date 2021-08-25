import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/domain/entities/personal_schedule_entities.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/models/model.dart';
import 'package:schedule/presentation/widget/personal_schedule_element_widget.dart';
import 'package:schedule/presentation/widget/spacing_box_widget.dart';
import 'package:schedule/presentation/widget/widgets_constants.dart';

class PersonalScheduleWidget extends StatelessWidget {
  final dynamic state;

  PersonalScheduleWidget({required this.state});

  @override
  Widget build(BuildContext context) {
    List<PersonalScheduleEntities>? personalSchedulesOfDay =
        state.schedulesPersonalOfDay;
    return Card(
      semanticContainer: true,
//      color: Color(0xffFCFAF3),
      color: AppColor.personalScheduleBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SpacingBoxWidget(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Personal',
                style: ThemeText.titleStyle.copyWith(fontWeight: FontWeight.bold,)),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColor.personalScheduleColor),
                margin: EdgeInsets.only(left: 4),
                padding: EdgeInsets.all(5),
                child: Text(
                  personalSchedulesOfDay != null
                      ? '${personalSchedulesOfDay.length}'
                      : '0',
                  style: ThemeText.numberStyle,
              )
              )
            ],
          ),
          Expanded(
            child: personalSchedulesOfDay != null
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: personalSchedulesOfDay.length,
                    itemBuilder: (context, index) {
                      PersonalScheduleEntities schedule = personalSchedulesOfDay[index];
                      return InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, '/todo-detail',
                              arguments: schedule),
                          child: PersonalScheduleElementWidget(
                            schedule: schedule,
                          ));
                    })
                : Align(
                    alignment: Alignment.center,
                    child: Text(
                      WidgetsConstants.noDataTxt,
                      style: ThemeText.textStyle.copyWith(color: AppColor.personalScheduleColor)
                  ),
          )
          )
        ],
      ),
    );
  }
}
