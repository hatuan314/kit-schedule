import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/presentation/screen/home_screen/calendarView/widgets/TimeDurationWidget.dart';
import 'package:schedule/presentation/screen/home_screen/calendarView/widgets/colonWidget.dart';

class EventItemWidget extends StatelessWidget {
  final String startTime;
  final String endTime;
  final String title;
  final String note;

  const EventItemWidget({Key key, this.startTime, this.endTime, this.title, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            TimeDuration(startTime: startTime, endTime: endTime),
            Container(
//                        height: 60.h,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ColonWidget()),
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
    );
  }
}
