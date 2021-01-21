import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/app_constance.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/presentation/screen/todo_screen/bloc/todo_bloc.dart';
import 'package:schedule/presentation/screen/todo_screen/bloc/todo_event.dart';
import 'package:schedule/presentation/screen/todo_screen/bloc/todo_state.dart';
import 'package:schedule/presentation/screen/todo_screen/todo_screen_constance.dart';
import 'package:schedule/presentation/screen/todo_screen/widget/select_date_time.dart';
import 'package:schedule/presentation/screen/todo_screen/widget/todo_text_field.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

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
          child: BlocConsumer<TodoBloc, TodoState>(
            listener: (context, state) {
              if (state is TodoCreateSuccess)
                Navigator.pop(context);
              return SizedBox();
            },
            // ignore: missing_return
            builder: (context, state) {
              if (state is TodoInitState)
                return SizedBox();
              else if (state is TodoSelectSuccess) {
                return SingleChildScrollView(
                  child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TodoTextField(
                            controller: _titleController,
                            widget: Icon(
                                Icons.note, size: AppConstance.iconSize),
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
                          SelectDateTime(
                            dateTime: state.date,
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (value) {
                              BlocProvider.of<TodoBloc>(context)
                                ..add(SelectDateEvent(date: value));
                            },
                            widget: Icon(Icons.calendar_today,
                                size: AppConstance.iconSize),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
                          ),
                          SelectDateTime(
                            dateTime: state.time,
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (value) {
                              BlocProvider.of<TodoBloc>(context)
                                ..add(SelectTimeEvent(time: value));
                            },
                            widget: Icon(
                                Icons.timer, size: AppConstance.iconSize),
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
                );
              }else return SizedBox();
            },
          ),
        ),
      ),
    );
  }

  _createTodo() {
    if (formKey.currentState.validate()) {
      BlocProvider.of<TodoBloc>(context)
        ..add(CreateTodoEvent(title: _titleController.text,
            note: _noteController.text));
    }
  }
}
