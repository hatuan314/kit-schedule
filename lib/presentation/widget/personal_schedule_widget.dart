import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:schedule/blocs/blocs.dart';

import 'package:schedule/domain/entities/personal_schedule_entities.dart';

import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/models/model.dart';
import 'package:schedule/presentation/widget/personal_schedule_element_widget.dart';
import 'package:schedule/presentation/widget/spacing_box_widget.dart';
import 'package:schedule/presentation/widget/widgets_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PersonalScheduleWidget extends StatelessWidget {
  final dynamic state;

  PersonalScheduleWidget({required this.state});

  @override
  Widget build(BuildContext context) {
    List<PersonalScheduleEntities>? personalSchedulesOfDay =
        state.schedulesPersonalOfDay;
    return Card(
      semanticContainer: true,
//      color: Color(0xffFCFAF3),
      color: AppColor.personalScheduleBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SpacingBoxWidget(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.personal,
                  style: ThemeText.titleStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
              Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.personalScheduleColor),
                  margin: EdgeInsets.only(left: 4),
                  padding: EdgeInsets.all(5),
                  child: Text(
                    personalSchedulesOfDay != null
                        ? '${personalSchedulesOfDay.length}'
                        : '0',
                    style: ThemeText.numberStyle,
                  ))
            ],
          ),
          Expanded(
              child: personalSchedulesOfDay != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: personalSchedulesOfDay.length,
                      itemBuilder: (context, index) {
                        PersonalScheduleEntities schedule =
                            personalSchedulesOfDay[index];
                        return InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (dialogContext) =>
                                      toDoDetailsDialog(context, schedule));
                            },
                            child: PersonalScheduleElementWidget(
                              schedule: schedule,
                            ));
                      })
                  : Align(
                      alignment: Alignment.center,
                      child: Text(AppLocalizations.of(context)!.noData,
                          style: ThemeText.textStyle
                              .copyWith(color: AppColor.personalScheduleColor)),
                    ))
        ],
      ),
    );
  }

  Widget toDoDetailsDialog(
      BuildContext context, PersonalScheduleEntities toDoItem) {
    return SimpleDialog(
        titlePadding: EdgeInsets.all(0),
        title: Container(
          padding: EdgeInsets.all(WidgetsConstants.contentPadding),
          width: MediaQuery.of(context).size.width,
          color: AppColor.personalScheduleColor2,
          child: Text(
            AppLocalizations.of(context)!.details,
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
                Padding(
                  padding:
                      EdgeInsets.only(bottom: WidgetsConstants.contentPadding),
                  child: Text(
                      toDoItem.name != null ? toDoItem.name as String : '',
                      style: ThemeText.titleStyle2
                          .copyWith(color: AppColor.personalScheduleColor2)),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: WidgetsConstants.contentPadding),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: RichText(
                      text: TextSpan(
                        text: '${AppLocalizations.of(context)!.time}: ',
                        style: ThemeText.titleStyle2
                            .copyWith(color: AppColor.personalScheduleColor2),
                        children: <TextSpan>[
                          TextSpan(
                              text: getTime(toDoItem),
                              style: ThemeText.titleStyle2.copyWith(
                                  color: AppColor.personalScheduleColor2,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: WidgetsConstants.contentPadding),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: RichText(
                      text: TextSpan(
                        text: '${AppLocalizations.of(context)!.note}: ',
                        style: ThemeText.titleStyle2
                            .copyWith(color: AppColor.personalScheduleColor2),
                        children: <TextSpan>[
                          TextSpan(
                              text: toDoItem.note != null ? toDoItem.note : '',
                              style: ThemeText.titleStyle2.copyWith(
                                  color: AppColor.personalScheduleColor2,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              padding: EdgeInsets.symmetric(
                  horizontal: WidgetsConstants.paddingHorizontal),
              onPressed: () {
                debugPrint(toDoItem.id);
                Navigator.pop(context);
                Navigator.pushNamed(context, '/todo-detail',
                        arguments: toDoItem)
                    .then((value) {
                  if (value != null) {
                    BlocProvider.of<CalendarBloc>(context)
                        .add(GetAllScheduleDataEvent());
                  }
                });
              },
              icon: Icon(Icons.edit),
              color: AppColor.personalScheduleColor2,
            ),
          )
        ]);
  }

  String getTime(PersonalScheduleEntities item) {
    String str = '';
    if (item.timer != null) str = str + (item.timer as String) + ' ';
    if (item.date != null)
      str += DateFormat('dd/MM/yyyy').format(
          DateTime.fromMillisecondsSinceEpoch(int.parse(item.date as String)));
    return str;
  }
}
