import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/presentation/journey/home_screen/calendarView/widgets/colonWidget.dart';

class EventItemWidget extends StatelessWidget {
  const EventItemWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  "07:00",
                  style: TextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "09:30",
                  style: TextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
//                        height: 60.h,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ColonWidget()),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nguyên lý hệ điều hành-2-20 (A15C310)',
                      //maxLines: 2,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp)),
                  Text(
                    '102_TA2',
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