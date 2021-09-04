import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:schedule/common/constants/layout_constants.dart';
import 'package:schedule/domain/entities/personal_schedule_entities.dart';

import 'package:schedule/presentation/journey/home/calendar_tab_constants.dart';
import 'package:schedule/presentation/journey/todo_screen/todo_constants.dart';
import 'package:schedule/presentation/journey/todo_screen/widgets/cupertino_rounded_datepicker_widget.dart';

import 'package:schedule/presentation/journey/todo_screen/widgets/todo_form_widget.dart';

import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/presentation/widget/loading_widget/loading_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/todo_bloc.dart';
import 'package:schedule/common/extension/date_time_extension.dart';

class TodoScreen extends StatefulWidget {
  final PersonalScheduleEntities? personalSchedule;

  TodoScreen({Key? key, this.personalSchedule}) : super(key: key);
  @override
  _CreateTodoTabViewState createState() => _CreateTodoTabViewState();
}

class _CreateTodoTabViewState extends State<TodoScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  bool isKeyboard = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {

    // TODO: implement initState
    if (widget.personalSchedule != null) {
      debugPrint(DateTime.utc(DateTime.now().year,DateTime.now().month,DateTime.now().day,0,0,0,0).millisecondsSinceEpoch.toString());
      debugPrint(widget.personalSchedule!.id);
      _nameController.text = widget.personalSchedule!.name!;
      _noteController.text = widget.personalSchedule!.note!;
    }
    KeyboardVisibilityController().onChange.listen((event) async {
      isKeyboard = event;
      if (isKeyboard == false) {
        await Future.delayed(Duration(milliseconds: 110));
        if (mounted) setState(() {});
      } else {
        if (mounted) setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondColor,
      appBar: widget.personalSchedule == null
          ? null
          : AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: BackButton(
                color: AppColor.personalScheduleColor2,
              ),
              actions: <Widget>[
                IconButton(
                    onPressed: () => _waitingDeleteDialog(),
                    icon: Icon(
                      Icons.delete,
                      color: AppColor.personalScheduleColor2,
                      size: ToDoConstants.iconSize,
                    ))
              ],
            ),
      body: SafeArea(
        child: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is TodoSuccessState) {
              if (widget.personalSchedule == null) {
                _noteController.text = "";
                _nameController.text = "";
              } else {
                Navigator.pop(context, 'ok');
              }
            } else if (state is TodoFailureState) {}
          },
          child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: CalendarTabConstants.paddingHorizontal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        widget.personalSchedule == null
                            ?   AppLocalizations.of(context)!.createTodo
                            : AppLocalizations.of(context)!.editTodo,
                        style: ThemeText.headerStyle2.copyWith(fontSize: 18.sp),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          child: TodoFormWidget(
                            state: state,
                            nameController: _nameController,
                            noteController: _noteController,
                            formKey: _formKey,
                            setDatePicker: _selectDatePicker,
                            setTimePicker: _selectTimePicker,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 10.h,
                  child: isKeyboard
                      ? SizedBox()
                      : Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  LayoutConstants.paddingHorizontal - 10.w),
                          child: state is TodoLoadingState
                              ? Container(
                                  child: LoadingWidget(),
                                )
                              : GestureDetector(
                                  onTap: widget.personalSchedule == null
                                      ? _setOnClickSaveButton
                                      : _setOnClickUpdateButton,
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
                                      AppLocalizations.of(context)!.save,
                                      style: ThemeText.titleStyle.copyWith(
                                        color: AppColor.secondColor,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  _selectDatePicker(TodoState state) async {
    CupertinoRoundedDatePickerWidget.show(
      context,
      initialDate:
          DateTime.fromMillisecondsSinceEpoch(int.parse(state.selectDay!)),
      textColor: AppColor.personalScheduleColor,
      initialDatePickerMode: CupertinoDatePickerMode.date,
      fontFamily: 'MR',
      onDateTimeChanged: (dataTime) {
        BlocProvider.of<TodoBloc>(context)
          ..add(SelectDatePickerOnPressEvent(selectDay: dataTime));
      },
      borderRadius: 20,
      maximumYear: DateTime.now().year + 10,
      minimumYear: DateTime.now().year - 10,
    );
  }

  _selectTimePicker(TodoState state) async {
    List<String> hourAndMinues = state.selectTimer!.split(':');
    int time = (int.parse(hourAndMinues[0])*60*60*1000)+(int.parse(hourAndMinues[1])*60*1000);
    DateTime a = DateTime.fromMillisecondsSinceEpoch(
        DateTime(2021).millisecondsSinceEpoch + time);
    CupertinoRoundedDatePickerWidget.show(
      context,
      initialDate:a,
      textColor: AppColor.personalScheduleColor,
      initialDatePickerMode: CupertinoDatePickerMode.time,
      fontFamily: 'MR',
      onDateTimeChanged: (dataTime) {
        BlocProvider.of<TodoBloc>(context)
          ..add(SelectTimePickerOnPressEvent(
              timer: TimeOfDay.fromDateTime(dataTime)));
      },
      borderRadius: 20,
    );
  }

  _setOnClickSaveButton() {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<TodoBloc>(context)
        ..add(CreatePersonalScheduleOnPressEvent(
            _nameController.text.trim(), _noteController.text.trim()));
    }
  }

  _setOnClickUpdateButton() {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState!.validate()) {
      debugPrint('>>>>>>>>>>>.id: '+ (this.widget.personalSchedule!.id as String));
      BlocProvider.of<TodoBloc>(context)
        ..add(
          UpdatePersonalScheduleOnPressEvent(_nameController.text.trim(),
              _noteController.text.trim(), widget.personalSchedule!.createAt!),
        );
    }
  }

  _waitingDeleteDialog() {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: AppLocalizations.of(context)!.doYouWant,
                    style: ThemeText.titleStyle.copyWith(
                        color: Colors.black54, fontWeight: FontWeight.normal),
                    children: [
                      TextSpan(
                          text: AppLocalizations.of(context)!.delete,
                          style: ThemeText.titleStyle.copyWith(
                            color: AppColor.errorColor,
                          )),
                    ]),
              ),
              Text(
                '${this.widget.personalSchedule!.name}?',
                style: ThemeText.titleStyle.copyWith(
                  color: Colors.black54,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              )
            ],
          ),
        ),
        btnOk: GestureDetector(
          onTap: () => _bntOkDialogOnPress(context),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor.fourthColor,
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
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: ToDoConstants.paddingVertical,
                  horizontal: ToDoConstants.paddingHorizontal),
              child: Text(
                AppLocalizations.of(context)!.yes,
                style: ThemeText.buttonLabelStyle.copyWith(
                    color: AppColor.secondColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        btnCancel: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor.errorColor,
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
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: ToDoConstants.paddingVertical,
                  horizontal: ToDoConstants.paddingHorizontal),
              child: FittedBox(
                child: Text(AppLocalizations.of(context)!.no,
                    style: ThemeText.buttonLabelStyle.copyWith(
                        color: AppColor.secondColor,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        )).show();
  }

  _bntOkDialogOnPress(BuildContext context) {
    Navigator.pop(context);
    debugPrint( widget.personalSchedule!.id);
    BlocProvider.of<TodoBloc>(context)
      ..add(DetelePersonalScheduleOnPressEvent(widget.personalSchedule!));
  }
}
