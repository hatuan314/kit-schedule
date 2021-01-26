import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeDuration extends StatelessWidget {
  const TimeDuration({
    Key key,
    @required this.startTime,
    this.endTime,
  }) : super(key: key);

  final String startTime;
  final String endTime;

  @override
  Widget build(BuildContext context) {
    return (endTime != null)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                startTime,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                endTime,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ],
          )
        : Container(
            child: Text(
              startTime,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          );
  }
}
