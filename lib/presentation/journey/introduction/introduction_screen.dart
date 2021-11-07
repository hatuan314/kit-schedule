import 'package:flutter/material.dart';
import 'package:schedule/presentation/journey/main/main_constants.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/service/share_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'introduction_constants.dart';

class IntroductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: IntroductionConstants.padding),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(IntroductionConstants.padding),
                child: Container(
                  padding: EdgeInsets.all(IntroductionConstants.padding),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.personalScheduleBackgroundColor),
                  child: Icon(
                    Icons.event,
                    color: AppColor.personalScheduleColor2,
                    size: IntroductionConstants.iconSize,
                  ),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.introduction,
                style: ThemeText.labelStyle.copyWith(
                  color: AppColor.personalScheduleColor2,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          ShareService _shareService = ShareService();
          _shareService.setIsFirstRun(false);
          Navigator.pushReplacementNamed(context, '/home');
        },
        child: Container(
            padding: EdgeInsets.all(IntroductionConstants.padding),
            child: Text(
              AppLocalizations.of(context)!.ok,
              style: ThemeText.buttonLabelStyle
                  .copyWith(color: AppColor.personalScheduleColor2),
            )),
      ),
    );
  }
}
