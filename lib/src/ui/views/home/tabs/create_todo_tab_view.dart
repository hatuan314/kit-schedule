/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:schedule/src/blocs/todo/todo_bloc.dart';
import 'package:schedule/src/utils/utils.dart';
import 'package:toast/toast.dart';

class CreateTodoTabView extends StatefulWidget {
  @override
  _CreateTodoTabViewState createState() => _CreateTodoTabViewState();
}

class _CreateTodoTabViewState extends State<CreateTodoTabView> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SafeArea(
        child: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is TodoSuccessState) {
              Toast.show('Create Success', context,
                  backgroundColor: Colors.green, textColor: Colors.white);
            } else if (state is TodoFailureState) {
              Toast.show('Create Failed', context,
                  backgroundColor: Colors.red, textColor: Colors.white);
            }
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
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: ScUtil.getInstance().setWidth(50)),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Create your todo',
                  style: TextStyle(
                      fontSize: ScUtil.getInstance().setSp(42),
                      color: Color(0xffFCFAF3),
                      fontFamily: 'MR',
                      fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () => _selectDatePicker(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScUtil.getInstance().setHeight(5)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/img/ic-calendar.svg',
                        color: Color(0xffFCFAF3),
                        height: ScUtil.getInstance().setHeight(18),
                      ),
                      SizedBox(
                        width: ScUtil.getInstance().setWidth(18),
                      ),
                      Text(
                        state.selectDay != null
                            ? '${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(int.parse(state.selectDay)))}'
                            : '',
                        style: TextStyle(
                            fontSize: ScUtil.getInstance().setSp(28),
                            color: Color(0xffFCFAF3),
                            fontFamily: 'MR',
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: ScUtil.getInstance().setWidth(50)),
            child: SvgPicture.asset(
              'assets/img/kit_schedule_logo.svg',
              width: ScUtil.getInstance().setHeight(60),
            ),
          )
        ],
      ),
    );
  }

  _todoFormWidget(TodoState state) {
    return Form(
        key: _formKey,
        child: Container(
            decoration: BoxDecoration(
                color: Color(0xffFCFAF3),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30))),
            padding: EdgeInsets.only(
                left: ScUtil.getInstance().setWidth(50),
                top: ScUtil.getInstance().setWidth(75),
                right: ScUtil.getInstance().setWidth(50),
                bottom: ScUtil.getInstance().setWidth(50)),
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: ScUtil.getInstance().setSp(32),
                            fontFamily: "MR"),
                        cursorColor: Colors.blue[800],
                        decoration: InputDecoration(
                            errorStyle: TextStyle(
                                fontSize: ScUtil.getInstance().setSp(24),
                                color: Colors.redAccent,
                                fontFamily: "MR"),
                            errorMaxLines: 2,
                            labelText: 'Title',
                            labelStyle: TextStyle(
                                fontSize: ScUtil.getInstance().setSp(32),
                                color: Colors.blue[800],
                                fontWeight: FontWeight.w500,
                                fontFamily: "MR"),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue[800],
                                    width: ScUtil.getInstance().setWidth(3)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.redAccent,
                                    width: ScUtil.getInstance().setWidth(3)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue[800],
                                    width: ScUtil.getInstance().setWidth(3)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Trường này không được bỏ trống";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: ScUtil.getInstance().setHeight(20),
                      ),
                      TextFormField(
                        controller: _noteController,
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: ScUtil.getInstance().setSp(32),
                            fontFamily: "MR"),
                        maxLines: 5,
                        cursorColor: Colors.blue[800],
                        decoration: InputDecoration(
                            errorStyle: TextStyle(
                                fontSize: ScUtil.getInstance().setSp(24),
                                color: Colors.redAccent,
                                fontFamily: "MR"),
                            errorMaxLines: 2,
                            labelText: 'Note',
                            labelStyle: TextStyle(
                                fontSize: ScUtil.getInstance().setSp(32),
                                color: Colors.blue[800],
                                fontWeight: FontWeight.w500,
                                fontFamily: "MR"),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue[800],
                                    width: ScUtil.getInstance().setWidth(3)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.redAccent,
                                    width: ScUtil.getInstance().setWidth(3)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue[800],
                                    width: ScUtil.getInstance().setWidth(3)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Trường này không được bỏ trống";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: ScUtil.getInstance().setHeight(20),
                      ),
                      Text(
                        'Set time',
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: ScUtil.getInstance().setSp(38),
                            fontFamily: 'MR',
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: ScUtil.getInstance().setHeight(10),
                      ),
                      InkWell(
                        onTap: () => _selectTimePicker(),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                  color: Colors.blue[800],
                                  width: ScUtil.getInstance().setWidth(3))),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: ScUtil.getInstance().setHeight(12)),
                          child: Text(
                            state.selectTimer != null
                                ? '${state.selectTimer}'
                                : '',
                            style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: ScUtil.getInstance().setSp(32),
                                fontFamily: 'MR',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScUtil.getInstance().setHeight(30),
                      ),
                      state is TodoLoadingState
                          ? Container(
                              child: LoadingWidget(
                                color: Colors.blue,
                                size: 40.0,
                              ),
                            )
                          : RaisedButton(
                              onPressed: () => _setOnClickSaveButton(state),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              color: Colors.blue[900],
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        ScUtil.getInstance().setHeight(12)),
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Color(0xffFCFAF3),
                                      fontSize: ScUtil.getInstance().setSp(36),
                                      fontFamily: 'MR',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ],
            )));
  }

  _selectDatePicker() async {
    DateTime date = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
      borderRadius: 20,
      fontFamily: 'MR',
      imageHeader: AssetImage("assets/img/calendar_header.jpg"),
    );
    BlocProvider.of<TodoBloc>(context)
      ..add(SelectDatePickerOnPressEvent(selectDay: date));
  }

  _selectTimePicker() async {
    TimeOfDay timer = await showRoundedTimePicker(
        context: context, initialTime: TimeOfDay.now(), borderRadius: 20);
    BlocProvider.of<TodoBloc>(context)
      ..add(SelectTimePickerOnPressEvent(timer: timer));
  }

  _setOnClickSaveButton(TodoState state) {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState.validate()) {
      BlocProvider.of<TodoBloc>(context)
        ..add(CreatePersonalScheduleOnPressEvent(
            _nameController.text.trim(), _noteController.text.trim()));
      if (state is TodoSuccessState) {
        _noteController.text = "";
        _nameController.text = "";
      }
    }
  }
}
*/
