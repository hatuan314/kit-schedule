import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/constants/route_constants.dart';
import 'package:schedule/presentation/journey/home/calendar_tab_constants.dart';
import 'package:schedule/presentation/journey/profile/profile_constants.dart';
import 'package:schedule/presentation/journey/scores/widgets/header_scores_widget.dart';
import 'package:schedule/presentation/journey/scores/widgets/srores_cell.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';

class ScoresScreen extends StatelessWidget {
  const ScoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondColor,
        appBar: AppBar(
          backgroundColor: AppColor.secondColor,
          elevation: 0,
          leading: Center(
              child: Text(
            'My scores',
            style: ThemeText.titleStyle.copyWith(fontSize: 18),
          )),
          leadingWidth: 150,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteList.addScores);
                },
                icon: Icon(
                  Icons.add,
                  color: AppColor.personalScheduleColor,
                )),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: CalendarTabConstants.paddingHorizontal),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade100, shape: BoxShape.circle),
                      child: Text(
                        '4.0',
                        style: ThemeText.headerStyle2.copyWith(fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: ProfileConstants.paddingVertical),
                      child: Text(
                        'AT16054',
                        textAlign: TextAlign.center,
                        style: ThemeText.headerStyle2,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.personalScheduleColor),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HeaderScoresWidget(),
                      Expanded(
                        child: ListView.builder(
                            itemCount: 100,
                            itemBuilder: (context, index) {
                              return ScoresCell();
                            }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ))
        /**/
        );
  }
}
