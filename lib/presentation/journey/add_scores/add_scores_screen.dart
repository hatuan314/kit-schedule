import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/common/enums/view_state.dart';
import 'package:schedule/domain/entities/subject_entities.dart';
import 'package:schedule/presentation/journey/add_scores/add_score_constants.dart';
import 'package:schedule/presentation/journey/add_scores/bloc/add_score_bloc.dart';
import 'package:schedule/presentation/journey/add_scores/bloc/add_score_event.dart';
import 'package:schedule/presentation/journey/add_scores/bloc/add_score_state.dart';
import 'package:schedule/presentation/themes/theme_border.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:schedule/presentation/widget/text_field_widget/text_field_widget.dart';

class AddScoresScreen extends StatelessWidget {
  TextEditingController componentScore1Controller = TextEditingController();

  TextEditingController componentScore2Controller = TextEditingController();

  TextEditingController finalScoreController = TextEditingController();

  Widget build(BuildContext context) {
    return BlocBuilder<AddScoreBloc, AddScoreState>(
        builder: (context, addScoreState) {
      return Scaffold(
        backgroundColor: AppColor.secondColor,
        body: addScoreState.viewState == ViewState.busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AddScoreConstants.padding),
                child: ListView(
                  children: [
                    _buildAppbar(context),

                    Visibility(
                     // visible: addScoreState.avgScore >= 0,
                      child: Padding(
                        padding: EdgeInsets.all(AddScoreConstants.padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildScoreContainer('3.2'),
                            _buildScoreContainer('A'),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        _buildTitle(AppLocalizations.of(context)!.grade),
                        _buildTitle(addScoreState.grade),
                      ],
                    ),
                    _buildTitle(AppLocalizations.of(context)!.subject),
                    _buildStateDropDownButton(context, addScoreState),
                    _buildTitleTextField(
                        context,
                        addScoreState,
                        componentScore1Controller,
                        AppLocalizations.of(context)!.componentScore1),
                    _buildTitleTextField(
                        context,
                        addScoreState,
                        componentScore2Controller,
                        AppLocalizations.of(context)!.componentScore2),
                    _buildTitleTextField(
                        context,
                        addScoreState,
                        finalScoreController,
                        AppLocalizations.of(context)!.finalTermScore),


                    Padding(
                      padding: EdgeInsets.only(top: AddScoreConstants.padding),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColor.personalScheduleColor2,
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.primaryColor.withOpacity(0.3),
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: Offset(
                                0,
                                3,
                              ),
                            )
                          ],
                        ),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          AppLocalizations.of(context)!.calculateScore,
                          style: ThemeText.titleStyle.copyWith(
                            color: AppColor.secondColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.secondColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.close,
          color: AppColor.personalScheduleColor,
        ),
      ),
      title: Text(
        AppLocalizations.of(context)!.addScore,
        style:
            ThemeText.titleStyle.copyWith(fontSize: AddScoreConstants.fontSize),
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.check,
            color: AppColor.personalScheduleColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTitleTextField(BuildContext context, AddScoreState addScoreState,
      TextEditingController controller, String title) {
    return Padding(
      padding: EdgeInsets.only(top: AddScoreConstants.padding),
      child: TextFieldWidget(
        controller: controller,
        labelText: title,
        textStyle: ThemeText.labelStyle,
        colorBoder: AppColor.personalScheduleColor,
        validate: (value) {
          if (value!.trim().isEmpty) {
            return AppLocalizations.of(context)!.isEmpty;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildStateDropDownButton(
      BuildContext context, AddScoreState addScoreState) {
    return Container(
        margin: EdgeInsets.only(top: AddScoreConstants.padding / 2),
        width: double.infinity,
        decoration: BoxDecoration(
            border:
                Border.all(color: AppColor.personalScheduleColor, width: 0.5),
            borderRadius: ThemeBorder.borderRadiusAll),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AddScoreConstants.padding,
              horizontal: AddScoreConstants.padding),
          child: DropdownButton<SubjectEntities>(
            underline: SizedBox(),
            isDense: true,
            dropdownColor: AppColor.secondColor,
            style: ThemeText.labelStyle,
            isExpanded: true,
            value: addScoreState.subject,
            onChanged: (newState) {
              BlocProvider.of<AddScoreBloc>(context)
                  .add(EditSubjectEvent(subject: newState as SubjectEntities));
            },
            icon: Icon(Icons.arrow_drop_down),
            items: addScoreState.subjectsList
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.subjectId == 0
                            ? AppLocalizations.of(context)!.updateSubject
                            : e.subjectName!,
                        style: ThemeText.labelStyle,
                      ),
                    ))
                .toList(),
          ),
        ));
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: AddScoreConstants.padding),
      child: Text(
        title,
        style:
            ThemeText.titleStyle.copyWith(fontSize: AddScoreConstants.fontSize),
      ),
    );
  }

  Widget _buildScoreContainer(String data) {
    return Container(
      height: AddScoreConstants.scoreContainerSize,
      width: AddScoreConstants.scoreContainerSize,
      margin: EdgeInsets.all(AddScoreConstants.padding),
      padding: EdgeInsets.all(AddScoreConstants.padding / 2),
      decoration: BoxDecoration(
          color: AppColor.personalScheduleBackgroundColor,
          shape: BoxShape.circle),
      child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            data,
            style: TextStyle(
                fontSize: AddScoreConstants.scoreContainerFontSize,
                color: AppColor.signInColor,
                fontFamily: 'MR',
                fontWeight: FontWeight.w600),
          )),

    );
  }
}
