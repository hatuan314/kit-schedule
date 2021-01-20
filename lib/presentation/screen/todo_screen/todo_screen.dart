import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:schedule/common/app_constance.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/presentation/screen/todo_screen/todo_screen_constance.dart';
import 'package:schedule/presentation/screen/todo_screen/widget/date_time_field.dart';
import 'package:schedule/presentation/screen/todo_screen/widget/todo_text_field.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _titleController;
  TextEditingController _noteController;
  DateTime selectDate = DateTime.now();
  DateTime selectTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.secondColor,
      appBar: AppBar(
        title: Text(
          TodoScreenConstance.appBarTitle,
          style: ThemeText.titleStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(40),
              horizontal: ScreenUtil().setWidth(20)),
          child: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TodoTextField(
                      controller: _titleController,
                      widget: Icon(Icons.note, size: AppConstance.iconSize),
                      hintText: 'Title',
                      validate: (value) {
                        if (value == null || value.isEmpty)
                          return TodoScreenConstance.errorNote;
                        else
                          return null;
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    TodoTextField(
                      controller: _noteController,
                      widget: Icon(
                        Icons.sticky_note_2,
                        size: AppConstance.iconSize,
                      ),
                      hintText: 'Note',
                      maxLine: 5,
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    InkWell(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (_) => SizedBox(
                              height: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height /
                                  3,
                              width: double.infinity,
                              child: CupertinoDatePicker(
                                  backgroundColor: ThemeColor.secondColor,
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: DateTime.now(),
                                  onDateTimeChanged: (value) {
                                    setState(() {
                                      selectDate = value;
                                    });
                                  }),
                            ),
                          );
                        },
                        child: DateTimeField(
                          widget: Icon(Icons.calendar_today,
                              size: AppConstance.iconSize),
                          dateTime: DateFormat('yyyy-MM-dd').format(selectDate),
                        )),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    InkWell(
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (_) => SizedBox(
                            height:
                                MediaQuery.of(context).copyWith().size.height /
                                    3,
                            width: double.infinity,
                            child: CupertinoDatePicker(
                                backgroundColor: ThemeColor.secondColor,
                                use24hFormat: true,
                                mode: CupertinoDatePickerMode.time,
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (value) {
                                  setState(() {
                                    selectTime = value;
                                  });
                                }),
                          ),
                        );
                      },
                      child: DateTimeField(
                        widget: Icon(Icons.timer, size: AppConstance.iconSize),
                        dateTime: DateFormat('kk:mm').format(selectTime),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(50),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(50),
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: _createTodo,
                        child: Text(
                          TodoScreenConstance.createTodo,
                          style: ThemeText.textStyle,
                        ),
                        color: Colors.lightBlue,
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  _createTodo() {
    if (formKey.currentState.validate()) {
      print('success');
    } else {
      print('failed');
    }
  }
}
