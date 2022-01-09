import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/enums/view_state.dart';
import 'package:schedule/common/utils/convert.dart';
import 'package:schedule/domain/entities/subject_entities.dart';
import 'package:schedule/presentation/journey/add_scores/add_score_constants.dart';
import 'package:schedule/presentation/journey/add_scores/bloc/add_score_bloc.dart';
import 'package:schedule/presentation/journey/add_scores/bloc/add_score_event.dart';
import 'package:schedule/presentation/journey/add_scores/bloc/add_score_state.dart';
import 'package:schedule/presentation/journey/search_subject/search_subject_dialog.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:schedule/presentation/widget/text_field_widget/text_field_widget.dart';

class AddScoresScreen extends StatelessWidget {
  TextEditingController componentScore1Controller = TextEditingController();

  TextEditingController componentScore2Controller = TextEditingController();

  TextEditingController finalScoreController = TextEditingController();

  GlobalKey<FormState> _textFormKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return BlocConsumer<AddScoreBloc, AddScoreState>(
        listener: (context, addScoreState) {
      if (addScoreState.viewState == ViewState.success) {
        Navigator.pop(context, true);
      }
    }, builder: (context, addScoreState) {
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
                      visible: addScoreState.avgScore >= 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AddScoreConstants.padding,
                            horizontal: AddScoreConstants.padding / 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildScoreContainer(
                                addScoreState.avgScore.toString()),
                            _buildScoreContainer(
                                Convert.scoreConvert(addScoreState.avgScore)),
                            _buildScoreContainer(Convert.letterScoreConvert[
                                    Convert.scoreConvert(
                                        addScoreState.avgScore)]
                                .toString()),
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
                    Padding(
                      padding: EdgeInsets.only(top: AddScoreConstants.padding),
                      child: GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (_) => SearchSubjectDialog(
                                          grade: addScoreState.grade,
                                        )));
                            if (result != null) {
                              BlocProvider.of<AddScoreBloc>(context).add(
                                  EditSubjectEvent(
                                      subject: result as SubjectEntities));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.personalScheduleColor,
                                    width: 0.5),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: EdgeInsets.all(18.sp),
                              child: Text(
                                addScoreState.subject.subjectName ==''?
                                    AppLocalizations.of(context)!.chooseSubject: addScoreState.subject.subjectName!,
                                style: ThemeText.labelStyle
                                    .copyWith(fontSize: 14.sp),
                              ),
                            ),
                          )),
                    ),
                    Form(
                        key: _textFormKey,
                        child: Column(
                          children: [
                            _buildScoreTextField(
                                context,
                                addScoreState,
                                componentScore1Controller,
                                AppLocalizations.of(context)!.componentScore1),
                            _buildScoreTextField(
                                context,
                                addScoreState,
                                componentScore2Controller,
                                AppLocalizations.of(context)!.componentScore2),
                            _buildScoreTextField(
                                context,
                                addScoreState,
                                finalScoreController,
                                AppLocalizations.of(context)!.finalTermScore),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: AddScoreConstants.padding),
                      child: GestureDetector(
                        onTap: () {
                          if (_textFormKey.currentState!.validate()) {
                            BlocProvider.of<AddScoreBloc>(context).add(
                                CalculateScoreEvent(
                                    componentScore1: double.parse(
                                        componentScore1Controller.text),
                                    componentScore2: double.parse(
                                        componentScore2Controller.text),
                                    finalTermScore: double.parse(
                                        finalScoreController.text)));
                          }
                        },
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
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Text(
                            AppLocalizations.of(context)!.calculateScore,
                            style: ThemeText.titleStyle.copyWith(
                                color: AppColor.secondColor, fontSize: 14.sp),
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
        onPressed: () => Navigator.pop(context, false),
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
          onPressed: () =>
              BlocProvider.of<AddScoreBloc>(context).add(SaveNewScoreEvent()),
          icon: Icon(
            Icons.check,
            color: AppColor.personalScheduleColor,
          ),
        ),
      ],
    );
  }

  Widget _buildScoreTextField(BuildContext context, AddScoreState addScoreState,
      TextEditingController controller, String title) {
    return Padding(
      padding: EdgeInsets.only(top: AddScoreConstants.padding),
      child: TextFieldWidget(
        controller: controller,
        labelText: title,
        textStyle: ThemeText.labelStyle.copyWith(fontSize: 14.sp),
        colorBoder: AppColor.personalScheduleColor,
        inputType: TextInputType.number,
        validate: (value) {
          if (value!.trim().isEmpty) {
            return AppLocalizations.of(context)!.isEmpty;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: AddScoreConstants.padding),
      child: Text(
        title,
        style: ThemeText.titleStyle.copyWith(fontSize: 14.sp),
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
            style: ThemeText.headerStyle2.copyWith(fontSize: 25.sp),
          )),
    );
  }
}
