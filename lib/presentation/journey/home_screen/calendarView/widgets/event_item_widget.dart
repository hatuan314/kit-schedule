import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/presentation/journey/home_screen/calendarView/widgets/colonWidget.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/presentation/journey/home_screen/calendarView/widgets/time_duration_widget.dart';

class EventItemWidget extends StatelessWidget {
  final String startTime;
  final String endTime;
  final String title;
  final String note;
  final Function onTap;

  const EventItemWidget({Key key, this.startTime, this.endTime, this.title, this.note,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: [
              TimeDuration(startTime: startTime, endTime: endTime),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.circle,color: ThemeColor.scheduleType,size: 16.sp,)),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp)),
                    Text(
                      note,
                      style: TextStyle(fontSize: 14.sp),
                    )
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
