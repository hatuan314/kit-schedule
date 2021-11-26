import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/common/enums/view_state.dart';
import 'package:schedule/common/utils/convert.dart';
import 'package:schedule/domain/entities/subject_entities.dart';
import 'package:schedule/presentation/journey/add_scores/add_score_constants.dart';
import 'package:schedule/presentation/journey/add_scores/bloc/add_score_bloc.dart';
import 'package:schedule/presentation/journey/add_scores/bloc/add_score_event.dart';
import 'package:schedule/presentation/journey/add_scores/bloc/add_score_state.dart';
import 'package:schedule/presentation/journey/add_scores/widgets/custom_select_item.dart';
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
                      visible: addScoreState.avgScore >= 0,
                      child: Padding(
                        padding:  EdgeInsets.only(top: AddScoreConstants.padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                     SizedBox(
                      height: AddScoreConstants.padding,
                    ),
                    // _buildTitle(AppLocalizations.of(context)!.subject),
                    _buildSubjectButton(context, addScoreState),
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
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            AppLocalizations.of(context)!.calculateScore,
                            style: ThemeText.titleStyle.copyWith(
                              color: AppColor.secondColor,
                            ),
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

  Widget _buildScoreTextField(BuildContext context, AddScoreState addScoreState,
      TextEditingController controller, String title) {
    return Padding(
      padding: EdgeInsets.only(top: AddScoreConstants.padding),
      child: TextFieldWidget(
        controller: controller,
        labelText: title,
        textStyle: ThemeText.labelStyle,
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

  Widget _buildSubjectButton(
      BuildContext context, AddScoreState addScoreState) {
    return CustomSelectMultiItem(context: context,items: ['qưeioqw'],onChange: (value){

    },);
    // return Autocomplete<SubjectEntities>(
    //   //  initialValue: _value,
    //   optionsBuilder: (TextEditingValue value) {
    //     BlocProvider.of<AddScoreBloc>(context)
    //         .add(SearchSubjectEvent(keyword: value.text));
    //     return addScoreState.subjectsList;
    //   },
    //   displayStringForOption: (value) => value.subjectName == ''
    //       ? AppLocalizations.of(context)!.updateSubject
    //       : value.subjectName!,
    //   fieldViewBuilder: (BuildContext context,
    //       TextEditingController fieldTextEditingController,
    //       FocusNode fieldFocusNode,
    //       VoidCallback onFieldSubmitted) {
    //     return TextFieldWidget(
    //       controller: fieldTextEditingController,
    //       focusNode: fieldFocusNode,
    //       textStyle: ThemeText.labelStyle,
    //       colorBoder: AppColor.personalScheduleColor,
    //       seffixIcon: IconButton(
    //           onPressed: () {
    //             BlocProvider.of<AddScoreBloc>(context)
    //                 .add(UpdateSubjectFromFirebaseEvent());
    //           },
    //           icon: Icon(
    //             Icons.update,
    //             color: AppColor.personalScheduleColor,
    //           )),
    //     );
    //   },
    //   optionsViewBuilder: (BuildContext context,
    //       AutocompleteOnSelected<SubjectEntities> onSelected,
    //       Iterable<SubjectEntities> options) {
    //     return Material(
    //       child: Container(
    //         margin: EdgeInsets.only(
    //             right: AddScoreConstants.padding,
    //             bottom: AddScoreConstants.padding),
    //         // height: 300,
    //         color: AppColor.secondColor,
    //         child: ListView.builder(
    //             itemCount: addScoreState.subjectsList.length,
    //             itemBuilder: (context, index) {
    //               //log(addScoreState.subjectsList[index].subjectName! +'nnnnnnn');
    //               return GestureDetector(
    //                 onTap: () {
    //                   onSelected(addScoreState.subjectsList[index]);
    //                 },
    //                 child: Container(
    //                   child: Padding(
    //                     padding: EdgeInsets.all(AddScoreConstants.padding),
    //                     child: Text(
    //                       addScoreState.subjectsList[index].subjectName!,
    //                       style: ThemeText.labelStyle,
    //                     ),
    //                   ),
    //                 ),
    //               );
    //             }),
    //       ),
    //     );
    //   },
    // );
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
