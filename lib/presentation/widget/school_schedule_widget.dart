import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/domain/entities/school_schedule_entities.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:schedule/presentation/widget/school_schedule_element_widget.dart';
import 'package:schedule/presentation/widget/spacing_box_widget.dart';
import 'package:schedule/presentation/widget/widgets_constants.dart';

class SchoolScheduleWidget extends StatelessWidget {
  final dynamic state;

  SchoolScheduleWidget({required this.state});

  @override
  Widget build(BuildContext context) {
    List<SchoolSchedule>? schoolSchedulesOfDay = state.schedulesSchoolOfDay;
    return Card(
      semanticContainer: true,
//      color: Color(0xffFCFAF3),
   //   margin: EdgeInsets.symmetric(
     //     vertical: WidgetsConstants.cardMargin),
      color: AppColor.scheduleBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SpacingBoxWidget(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.school,
                  style: ThemeText.titleStyle.copyWith(
                    color: AppColor.scheduleType,
                    fontWeight: FontWeight.bold,
                  )),
              Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                margin: EdgeInsets.only(left: ScreenUtil().setHeight(4)),
                padding: EdgeInsets.all(ScreenUtil().setHeight(5)),
                child: Text(
                    schoolSchedulesOfDay != null
                        ? '${schoolSchedulesOfDay.length}'
                        : '0',
                    style: ThemeText.numberStyle),
              )
            ],
          ),
          Expanded(
            child: schoolSchedulesOfDay != null
                ? Padding(
                  padding: const EdgeInsets.only(bottom: WidgetsConstants.cardMargin),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: schoolSchedulesOfDay.length,
                      itemBuilder: (context, index) {
                        SchoolSchedule schedule = schoolSchedulesOfDay[index];
                        return SchoolScheduleElementWidget(schedule: schedule);
                      }),
                )
                : Align(
                    alignment: Alignment.center,
                    child: Text(AppLocalizations.of(context)!.noData,
                        style: ThemeText.textStyle
                            .copyWith(color: AppColor.scheduleType)),
                  ),
          )
        ],
      ),
    );
  }
}
