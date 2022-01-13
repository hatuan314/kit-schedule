import 'package:flutter/material.dart';
import 'package:schedule/presentation/journey/scores/scores_constants.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderScoresWidget extends StatelessWidget {
  const HeaderScoresWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScoresConstants.heightHeaderRow,
      width: double.maxFinite,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: AppColor.personalScheduleColor))),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 6, child: nameBoard(AppLocalizations.of(context)!.subject)),
          Expanded(
              flex: 2, child: nameBoard(AppLocalizations.of(context)!.credits)),
          Expanded(
              flex: 2,
              child:
                  nameBoard(AppLocalizations.of(context)!.score)) // Expanded(
          //   child: Container(
          //     color: Colors.transparent,
          //     child: Row(
          //       children: [
          //         nameBoard(AppLocalizations.of(context)!.credits),
          //         Expanded(
          //           flex: 2,
          //           child: Container(
          //             color: Colors.transparent,
          //             child: Column(
          //               children: [
          //                 Expanded(
          //                   child: Container(
          //                     decoration: BoxDecoration(
          //                         color: Colors.transparent,
          //                         border: Border(
          //                             right: BorderSide(
          //                                 color:
          //                                     AppColor.personalScheduleColor),
          //                             bottom: BorderSide(
          //                                 color:
          //                                     AppColor.personalScheduleColor))),
          //                     alignment: Alignment.center,
          //                     child: Text(
          //                       AppLocalizations.of(context)!.score,
          //                       style: ThemeText.headerStyle2
          //                           .copyWith(fontSize: ScoresConstants.scoreFontSize),
          //                       textAlign: TextAlign.center,
          //                     ),
          //                   ),
          //                 ),
          //                 // Expanded(
          //                 //     child: Container(
          //                 //   color: Colors.transparent,
          //                 //   child: Row(
          //                 //     children: [nameBoard('Hệ 10'), nameBoard('Hệ 4')],
          //                 //   ),
          //                 // ))
          //               ],
          //             ),
          //           ),
          //         ),
          //      //   nameBoard('Điểm chữ', isBorderRight: false)
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget nameBoard(String title, {bool isBorderRight = true}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
              right: BorderSide(
                  color: isBorderRight
                      ? AppColor.personalScheduleColor
                      : Colors.transparent))),
      alignment: Alignment.center,
      child: Text(
        title,
        style: ThemeText.headerStyle2.copyWith(fontSize: 15.sp),
        textAlign: TextAlign.center,
      ),
    );
  }
}
