import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

import 'package:schedule/models/personal_schedule.dart';
import 'package:schedule/presentation/journey/todo_screen/todo_constants.dart';

import 'package:schedule/presentation/journey/todo_screen/widgets/todo_background_widget.dart';
import 'package:schedule/presentation/journey/todo_screen/widgets/todo_form_widget.dart';

import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';

import 'bloc/todo_bloc.dart';

class TodoScreen extends StatefulWidget {
  final PersonalSchedule? personalSchedule;

  const TodoScreen({Key? key, this.personalSchedule}) : super(key: key);
  @override
  _CreateTodoTabViewState createState() => _CreateTodoTabViewState();
}

class _CreateTodoTabViewState extends State<TodoScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    if (widget.personalSchedule != null) {
      _nameController.text = widget.personalSchedule!.name!;
      _noteController.text = widget.personalSchedule!.note!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColor.personalScheduleColor2,
      appBar: widget.personalSchedule == null
          ? null
          : AppBar(
              elevation: 0,
              actions: <Widget>[
                IconButton(
                    onPressed: () => _waitingDeleteDialog(),
                    icon: Icon(
                      Icons.delete,
                      color: AppColor.secondColor,
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
                Navigator.pushReplacementNamed(context, '/home');
              }
            } else if (state is TodoFailureState) {}
          },
          child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 25,
                  child: _todoBackgroundWidget(state),
                ),
                Expanded(
                  flex: 75,
                  child: _todoFormWidget(state),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  _todoBackgroundWidget(TodoState state) {
    return TodoBackgroundWidget(
      header: widget.personalSchedule==null?ToDoConstants.createToDoTxt:widget.personalSchedule!.name!,
        state: state, selectDataPicker: _selectDatePicker);
  }

  _todoFormWidget(TodoState state) {
    return TodoFormWidget(
      state: state,
      setOnClickSaveButton: this.widget.personalSchedule == null
          ? _setOnClickSaveButton
          : _setOnClickUpdateButton,
      setTimePicker: _selectTimePicker,
      nameController: _nameController,
      noteController: _noteController,
      formKey: _formKey,
    );
  }

  _selectDatePicker() async {
    DateTime? date = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
      borderRadius: 20,
      fontFamily: 'MR',
      imageHeader: AssetImage("assets/images/calendar_header.jpg"),
    );
    if (date != null) {
      BlocProvider.of<TodoBloc>(context)
        ..add(SelectDatePickerOnPressEvent(selectDay: date));
    }
  }

  _selectTimePicker() async {
    TimeOfDay? timer = await showRoundedTimePicker(
        context: context, initialTime: TimeOfDay.now(), borderRadius: 20);
    if (timer != null) {
      BlocProvider.of<TodoBloc>(context)
        ..add(SelectTimePickerOnPressEvent(timer: timer));
    }
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
      BlocProvider.of<TodoBloc>(context)
        ..add(UpdatePersonalScheduleOnPressEvent(
            this.widget.personalSchedule!.id,
            _nameController.text.trim(),
            _noteController.text.trim()));
    }
  }

  _waitingDeleteDialog() {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        body: Padding(
          padding:
              EdgeInsets.symmetric(vertical: ToDoConstants.paddingVertical),
          child: RichText(
            text: TextSpan(
                text: ToDoConstants.confirmDeleteTxt,
                style: ThemeText.titleStyle.copyWith(
                    color: Colors.black54, fontWeight: FontWeight.normal),
                children: [
                  TextSpan(
                      text: ToDoConstants.confirmDeleteTxt2,
                      style: ThemeText.titleStyle.copyWith(
                        color: AppColor.errorColor,
                      )),
                  TextSpan(
                    text: '${this.widget.personalSchedule!.name}?',
                    style: ThemeText.titleStyle.copyWith(
                        color: Colors.black54, fontWeight: FontWeight.normal),
                  ),
                ]),
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
                ToDoConstants.yesTxt,
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
              child: Text(ToDoConstants.noTxt,
                  style: ThemeText.buttonLabelStyle.copyWith(
                      color: AppColor.secondColor,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        )).show();
  }

  _bntOkDialogOnPress(BuildContext context) {
    BlocProvider.of<TodoBloc>(context)
      ..add(
          DetelePersonalScheduleOnPressEvent(this.widget.personalSchedule!.id));
  }
}
