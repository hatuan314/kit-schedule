import 'package:flutter/material.dart';
import 'package:schedule/presentation/journey/main/main_constants.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/service/share_service.dart';

class IntroductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.personalScheduleBackgroundColor),
                  child: Icon(
                    Icons.event,
                    color: AppColor.personalScheduleColor2,
                    size: 80.0,
                  ),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.introduction,
                style: ThemeText.titleStyle2
                     .copyWith(color: AppColor.personalScheduleColor2)
                ,
                textAlign: TextAlign.center,
              ),
              // Padding(
              //   padding:   EdgeInsets.only(top: 20.0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //           flex: 1,
              //           child: navBarItem(false, Icons.date_range,  )),
              //       Expanded(
              //           flex: 1,
              //           child: navBarItem(
              //               false, Icons.score_outlined,  )),
              //       Expanded(
              //           flex: 1,
              //           child:
              //           navBarItem(false, Icons.content_paste,  )),
              //       Expanded(
              //           flex: 1,
              //           child: navBarItem(true, Icons.person)),
              //     ],
              //   ),
              // )
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
          //color: AppColor.personalScheduleBackgroundColor,
        //  margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(20.0),
            child: Text(AppLocalizations.of(context)!.ok,
            style: ThemeText.buttonLabelStyle.copyWith(color: AppColor.personalScheduleColor2),)),
      ),
    );
  }
  Widget navBarItem( bool isSelected, IconData icon, ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.0,
          color: isSelected ? AppColor.personalScheduleColor2: AppColor.secondColor
        )
      ),
      height: MainScreenConstants.navBarHeight,
      child: Icon(
        icon,
        color: isSelected
            ? AppColor.fourthColor
            : AppColor.primaryColor,
      ),
    );
  }
}
