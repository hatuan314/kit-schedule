import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/presentation/journey/todo_screen/bloc/todo_bloc.dart';
import 'package:schedule/presentation/journey/todo_screen/todo_constants.dart';
import 'package:schedule/presentation/journey/todo_screen/widgets/set_time_widget.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/presentation/widget/loading_widget/loading_widget.dart';
import 'package:schedule/presentation/widget/text_field_widget/text_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodoFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController noteController;
  final TodoState state;
  final Function() setDatePicker;
  final Function() setTimePicker;
  final Function() setOnBtnSave;
  const TodoFormWidget(
      {Key? key,
      required this.formKey,
      required this.nameController,
      required this.noteController,
      required this.state,
      required this.setDatePicker,
      required this.setTimePicker,
      required this.setOnBtnSave})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().screenHeight - 180.h,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Form(
                key: formKey,
                child: TextFieldWidget(
                  controller: nameController,
                  labelText: ToDoConstants.titleTxt,
                  textStyle: ThemeText.labelStyle
                      .copyWith(fontWeight: FontWeight.w400),
                  colorBoder: AppColor.personalScheduleColor,
                  validate: (value) {
                    if (value!.trim().isEmpty) {
                      return "Trường này không được bỏ trống";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: ToDoConstants.spacingHeight,
              ),
              Row(
                children: [
                  Expanded(
                      child: SetTimeWidget(
                    state: state,
                    title: ToDoConstants.setDateTxt,
                    onTap: setDatePicker,
                    isDate: true,
                  )),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                      child: SetTimeWidget(
                    onTap: setTimePicker,
                    state: state,
                    title: ToDoConstants.setTimeTxt,
                  )),
                ],
              ),
              SizedBox(
                height: ToDoConstants.spacingHeight,
              ),
              TextFieldWidget(
                controller: noteController,
                labelText: ToDoConstants.noteTxt,
                textStyle:
                    ThemeText.labelStyle.copyWith(fontWeight: FontWeight.w400),
                colorBoder: AppColor.personalScheduleColor,
                maxLines: 5,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.h),
            child: state is TodoLoadingState
                ? Container(
                    child: LoadingWidget(),
                  )
                : GestureDetector(
                    onTap: setOnBtnSave,
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
                      padding: EdgeInsets.symmetric(
                          vertical:
                              ToDoConstants.setTimeContainerPaddingVertical),
                      child: Text(
                        ToDoConstants.saveTxt,
                        style: ThemeText.titleStyle.copyWith(
                          color: AppColor.secondColor,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
