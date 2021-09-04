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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TodoFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController noteController;
  final TodoState state;
  final Function(TodoState) setDatePicker;
  final Function(TodoState) setTimePicker;

  const TodoFormWidget({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.noteController,
    required this.state,
    required this.setDatePicker,
    required this.setTimePicker,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Column(
        children: [
          Form(
            key: formKey,
            child: TextFieldWidget(
              controller: nameController,
              labelText: AppLocalizations.of(context)!.title,
              textStyle:
                  ThemeText.labelStyle.copyWith(fontWeight: FontWeight.w400),
              colorBoder: AppColor.personalScheduleColor,
              validate: (value) {
                if (value!.trim().isEmpty) {
                  return AppLocalizations.of(context)!.isEmpty;
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
                title: AppLocalizations.of(context)!.setDate,
                onTap:()=> setDatePicker(state),
                isDate: true,
              )),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                  child: SetTimeWidget(
                onTap:()=> setTimePicker(state),
                state: state,
                title: AppLocalizations.of(context)!.setTime,
              )),
            ],
          ),
          SizedBox(
            height: ToDoConstants.spacingHeight,
          ),
          TextFieldWidget(
            controller: noteController,
            labelText:AppLocalizations.of(context)!.note,
            textStyle: ThemeText.labelStyle.copyWith(fontWeight: FontWeight.w400),
            colorBoder: AppColor.personalScheduleColor,
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
