import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/src/blocs/blocs.dart';
import 'package:schedule/src/models/model.dart';
import 'package:schedule/src/ui/views/home/tabs/widgets/school_schedule_element_widget.dart';
import 'package:schedule/src/ui/views/widgets_constants/spacing_box_widget.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';

class SchoolScheduleWidget extends StatelessWidget {
  final dynamic state;

  SchoolScheduleWidget({required this.state});

  @override
  Widget build(BuildContext context) {
    List<SchoolSchedule>? schoolSchedulesOfDay = state.schedulesSchoolOfDay;
    return Card(
      semanticContainer: true,
//      color: Color(0xffFCFAF3),
//    margin: EdgeInsets.symmetric(vertical: ScUtil.getInstance().setHeight(8)),
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
              Text(
                'School',
                style:ThemeText.titleStyle.copyWith(
                    color: AppColor.scheduleType,fontWeight: FontWeight.bold, fontSize: ScUtil().setSp(36))),
              Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                margin: EdgeInsets.only(left: ScUtil().setHeight(4)),
                padding: EdgeInsets.all(ScUtil().setHeight(5)),
                child: Text(
                  schoolSchedulesOfDay != null
                      ? '${schoolSchedulesOfDay.length}'
                      : '0',
                  style: ThemeText.numberStyle
                ),
              )
            ],
          ),
          Expanded(
            child: schoolSchedulesOfDay != null
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: schoolSchedulesOfDay.length,
                    itemBuilder: (context, index) {
                      SchoolSchedule schedule = schoolSchedulesOfDay[index];
                      return SchoolScheduleElementWidget(schedule: schedule);
                    })
                : Align(
                    alignment: Alignment.center,
                    child: Text(
                      'No Data',
                      style: ThemeText.titleStyle.copyWith(color: AppColor.scheduleType)),
                  ),
          )
        ],
      ),
    );
  }
}
