import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/presentation/journey/home/calendar_tab_constants.dart';
import 'package:schedule/presentation/journey/scores/scores_constants.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScoresScreen extends StatelessWidget {
  const ScoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondColor,

      body:
      SafeArea(
        child:
        Padding(
        padding: EdgeInsets.symmetric(
        horizontal: CalendarTabConstants.paddingHorizontal),
    child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text( ScoresConstants.myScoresTxt,
              style: ThemeText.headerStyle2.copyWith(fontSize: 18.h),
            ),

            Container(
              height: MediaQuery.of(context).size.height-127,
              child: Center(
                child: Text(
                  'This feature is lauching soon',
                  style: ThemeText.titleStyle2
                      .copyWith(color: AppColor.thirdColor),
                ),
              ),
            ),
          ],
        ),
      )
      )
      /**/
    );
  }
}
