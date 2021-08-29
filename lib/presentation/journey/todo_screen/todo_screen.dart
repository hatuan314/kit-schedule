import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/constants/layout_constants.dart';
import 'package:schedule/domain/entities/personal_schedule_entities.dart';

import 'package:schedule/models/personal_schedule.dart';
import 'package:schedule/presentation/journey/home/calendar_tab_constants.dart';
import 'package:schedule/presentation/journey/todo_screen/todo_constants.dart';

import 'package:schedule/presentation/journey/todo_screen/widgets/todo_form_widget.dart';

import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';

import 'bloc/todo_bloc.dart';

class TodoScreen extends StatefulWidget {
  final PersonalScheduleEntities? personalSchedule;

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
                Navigator.pop(context);
                Navigator.pop(context,'ok');
              }
            } else if (state is TodoFailureState) {}
          },
          child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
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
                          ? ToDoConstants.createToDoTxt
                          : ToDoConstants.editToDoTxt,
                      style: ThemeText.headerStyle2.copyWith(fontSize: 18.sp),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    TodoFormWidget(
                      state: state,
                      nameController: _nameController,
                      noteController: _noteController,
                      formKey: _formKey,
                      setDatePicker: _selectDatePicker,
                      setTimePicker: _selectTimePicker,
                      setOnBtnSave: widget.personalSchedule == null
                          ? _setOnClickSaveButton
                          : _setOnClickUpdateButton,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
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
        ..add(
          UpdatePersonalScheduleOnPressEvent(
              this.widget.personalSchedule!.id,
              _nameController.text.trim(),
              _noteController.text.trim(),
              widget.personalSchedule!.createAt!),
        );
    }
  }

  _waitingDeleteDialog() {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        body: Column(
          children: [
            RichText(
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
      ..add(DetelePersonalScheduleOnPressEvent(this.widget.personalSchedule!));
  }
}
