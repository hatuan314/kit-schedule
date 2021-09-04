import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/presentation/journey/home/calendar_tab_constants.dart';
import 'package:schedule/presentation/journey/scores/scores_constants.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScoresScreen extends StatelessWidget {
  const ScoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondColor,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: CalendarTabConstants.paddingHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Text(
                AppLocalizations.of(context)!.myScores,
                style: ThemeText.headerStyle2.copyWith(fontSize: 18.h),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.featureSoon,
                      style: ThemeText.titleStyle2
                          .copyWith(color: AppColor.thirdColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ))
        /**/
        );
  }
}
