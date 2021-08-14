import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/presentation/journey/todo_screen/bloc/todo_bloc.dart';
import 'package:schedule/presentation/journey/todo_screen/todo_constants.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/presentation/widget/loading_widget/loading_widget.dart';
import 'package:schedule/presentation/widget/spacing_box_widget.dart';
import 'package:schedule/presentation/widget/text_field_widget/text_field_widget.dart';

class TodoFormWidget extends StatelessWidget {
  final TodoState state;
  final Function() setOnClickSaveButton;
  final Function() setTimePicker;
  final TextEditingController nameController;
  final TextEditingController noteController;
  final GlobalKey<FormState> formKey;
  TodoFormWidget(
      {Key? key,
      required this.state,
      required this.setOnClickSaveButton,
      required this.setTimePicker,
      required this.nameController,
      required this.noteController,
       required this.formKey})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Container(
            decoration: BoxDecoration(
                color: AppColor.secondColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30))),
            padding: EdgeInsets.symmetric(
                vertical: ToDoConstants.paddingVertical,
                horizontal: ToDoConstants.paddingHorizontal),
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SpacingBoxWidget(height: 10),
                      TextFieldWidget(
                        controller: nameController,
                        labelText: ToDoConstants.titleTxt,
                        textStyle: ThemeText.labelStyle
                            .copyWith(fontWeight: FontWeight.w400),
                        colorBoder: AppColor.personalScheduleColor,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Trường này không được bỏ trống";
                          }
                          return null;
                        },
                      ),
                      SpacingBoxWidget(height: 20),
                      TextFieldWidget(
                        controller: noteController,
                        labelText: ToDoConstants.noteTxt,
                        textStyle: ThemeText.labelStyle
                            .copyWith(fontWeight: FontWeight.w400),
                        colorBoder: AppColor.personalScheduleColor,
                        maxLines: 5,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Trường này không được bỏ trống";
                          }
                          return null;
                        },
                      ),
                      SpacingBoxWidget(height: 20),
                      Text(ToDoConstants.setTimeTxt,
                          style: ThemeText.titleStyle),
                      SpacingBoxWidget(height: 10),
                      InkWell(
                        onTap: setTimePicker,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                  color: AppColor.personalScheduleColor,
                                  width: 0.5)),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: ToDoConstants
                                  .setTimeContainerPaddingVertical),
                          child: Text(
                            state.selectTimer != null
                                ? '${state.selectTimer}'
                                : '',
                            style: ThemeText.labelStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: ToDoConstants.timeFontSize),
                          ),
                        ),
                      ),
                      SpacingBoxWidget(height: 30.h),
                      state is TodoLoadingState
                          ? Container(
                              child: LoadingWidget(),
                            )
                          : GestureDetector(
                              onTap:setOnClickSaveButton,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColor.personalScheduleColor2,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.primaryColor
                                          .withOpacity(0.3),
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
                                padding: EdgeInsets.symmetric(
                                    vertical: ToDoConstants
                                        .setTimeContainerPaddingVertical),
                                child: Text(
                                  ToDoConstants.saveTxt,
                                  style: ThemeText.titleStyle.copyWith(
                                    color: AppColor.secondColor,
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ],
            )));
  }
}
