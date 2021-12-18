import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/constants/route_constants.dart';
import 'package:schedule/domain/entities/score_entities.dart';
import 'package:schedule/presentation/journey/home/calendar_tab_constants.dart';
import 'package:schedule/presentation/journey/profile/profile_constants.dart';
import 'package:schedule/presentation/journey/scores/bloc/scores_bloc.dart';
import 'package:schedule/presentation/journey/scores/bloc/scores_event.dart';
import 'package:schedule/presentation/journey/scores/bloc/scores_state.dart';
import 'package:schedule/presentation/journey/scores/widgets/header_scores_widget.dart';
import 'package:schedule/presentation/journey/scores/widgets/srores_cell.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/presentation/widget/widgets_constants.dart';

class ScoresScreen extends StatelessWidget {
  const ScoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoresBloc, ScoresState>(
        builder: (context, scoresState) {
      return !scoresState.isLogin
          ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Center(
                child: Text(
                  AppLocalizations.of(context)!.introInScoreScreen,
                  style: ThemeText.labelStyle.copyWith(
                    color: AppColor.personalScheduleColor2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          )
          : Scaffold(
              backgroundColor: AppColor.secondColor,
              appBar: AppBar(
                backgroundColor: AppColor.secondColor,
                elevation: 0,
                title: Text(
                  AppLocalizations.of(context)!.myScores,
                  textAlign: TextAlign.center,
                  style: ThemeText.headerStyle2.copyWith(fontSize: 18.sp),
                ),
                leadingWidth: 0,
                actions: [
                  IconButton(
                      onPressed: () async {
                        final result = await Navigator.pushNamed(
                            context, RouteList.addScores);
                        log(result.toString());
                        if (result is bool && result == true) {
                          BlocProvider.of<ScoresBloc>(context)
                              .add(LoadScoresEvent());
                          BlocProvider.of<ScoresBloc>(context)
                              .add(CalculateGpaScoreEvent());
                        }
                      },
                      icon: Icon(
                        Icons.add,
                        color: AppColor.personalScheduleColor,
                      )),
                  SizedBox(
                    width: 10.w,
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
                      height: 10.h,
                    ),
                    Container(
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10.h),
                            padding: EdgeInsets.all(20.h),
                            decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                shape: BoxShape.circle),
                            child: Text(
                              scoresState.gpa.toString(),
                              style: ThemeText.headerStyle2
                                  .copyWith(fontSize: 25.sp),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: ProfileConstants.paddingVertical),
                            child: Text(
                              scoresState.studentId,
                              textAlign: TextAlign.center,
                              style: ThemeText.headerStyle2,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColor.personalScheduleColor),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            HeaderScoresWidget(),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: scoresState.scores.length,
                                  itemBuilder: (context, index) {
                                    return Dismissible(
                                      key: Key(scoresState.scores[index].id
                                          .toString()),
                                      onDismissed: (direction) {
                                        BlocProvider.of<ScoresBloc>(context)
                                            .add(DeleteScoreEvent(
                                                scoresState.scores[index]));
                                        BlocProvider.of<ScoresBloc>(context)
                                            .add(CalculateGpaScoreEvent());
                                      },
                                      child: GestureDetector(
                                        onTap: () => showDialog(
                                            context: context,
                                            builder: (dialogContext) =>
                                                _scoreDetailsDialog(context,
                                                    scoresState.scores[index])),
                                        child: ScoresCell(
                                          subject: scoresState
                                                  .scores[index].subject ??
                                              '',
                                          credits: scoresState
                                                  .scores[index].credits ??
                                              0,
                                          scoreIn4: scoresState
                                                  .scores[index].scoreIn4 ??
                                              0.0,
                                          letterScore: scoresState
                                                  .scores[index].letter ??
                                              'F',
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )));
    });
  }

  Widget _scoreDetailsDialog(
      BuildContext context, ScoreEntities scoreEntities) {
    return SimpleDialog(
        titlePadding: EdgeInsets.all(0),
        title: Container(
          padding: EdgeInsets.all(WidgetsConstants.contentPadding),
          width: MediaQuery.of(context).size.width,
          color: AppColor.personalScheduleColor2,
          child: Text(
            scoreEntities.subject ?? '',
            style: ThemeText.titleStyle.copyWith(color: AppColor.secondColor),
          ),
        ),
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: WidgetsConstants.paddingHorizontal,
              //vertical: WidgetsConstants.paddingVertical
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailInfo(context,
                    title: AppLocalizations.of(context)!.p10PointGradingScale,
                    info: scoreEntities.scoreIn10.toString()),
                _buildDetailInfo(context,
                    title: AppLocalizations.of(context)!.p4PointGradingScale,
                    info: scoreEntities.scoreIn4.toString()),
                _buildDetailInfo(context,
                    title: AppLocalizations.of(context)!.letterGrade,
                    info: scoreEntities.letter.toString()),
              ],
            ),
          ),
        ]);
  }

  Widget _buildDetailInfo(BuildContext context,
      {required String title, required String info}) {
    return Padding(
      padding: EdgeInsets.only(bottom: WidgetsConstants.contentPadding),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: RichText(
          text: TextSpan(
            text: '${title}: ',
            style: ThemeText.titleStyle2
                .copyWith(color: AppColor.personalScheduleColor2),
            children: <TextSpan>[
              TextSpan(
                  text: info,
                  style: ThemeText.titleStyle2.copyWith(
                      color: AppColor.personalScheduleColor2,
                      fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }
}
