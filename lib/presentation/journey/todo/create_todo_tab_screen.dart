
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:schedule/blocs/todo/todo_bloc.dart';
import 'package:schedule/presentation/journey/todo/todo_constants.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/presentation/widget/loading_widget/loading_widget.dart';
import 'package:schedule/presentation/widget/spacing_box_widget.dart';
import 'package:schedule/presentation/widget/text_form_field_widget.dart';

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
      backgroundColor: AppColor.personalScheduleColor2,
      body: SafeArea(
        child: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is TodoSuccessState) {
              // Toast.show('Create Success', context,
              //     backgroundColor: Colors.green, textColor: Colors.white);
            } else if (state is TodoFailureState) {
              // Toast.show('Create Failed', context,
              //     backgroundColor: Colors.red, textColor: Colors.white);
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
      padding: const
          EdgeInsets.symmetric(horizontal: ToDoConstants.paddingHorizontal),
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
                  ToDoConstants.createToDoTxt,
                  style: ThemeText.headerStyle,
              ),
              ),
              InkWell(
                onTap: () => _selectDatePicker(),
                child: Padding(
                  padding:const EdgeInsets.symmetric(
                      vertical: ToDoConstants.inkWellPaddingVertical),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SvgPicture.asset(
                        ToDoConstants.calendarImgPath,
                        color:  AppColor.secondColor,
                        height:ToDoConstants.calendarImgHeight,
                      ),
                     SpacingBoxWidget(height: 18),
                      Text(
                        state.selectDay != null
                            ? '${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(int.parse(state.selectDay!)))}'
                            : '',
                        style: ThemeText.textInforStyle
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: ToDoConstants.paddingHorizontal),
            child: SvgPicture.asset(
              ToDoConstants.kitLogoPath,
              width: ToDoConstants.kitLogoWidth,
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
                color:  AppColor.secondColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30))),
            padding: EdgeInsets.symmetric(
              vertical: ToDoConstants.paddingVertical,
              horizontal: ToDoConstants.paddingHorizontal
            ),
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[ SpacingBoxWidget(height: 10),
                      TextFormFieldWidget(
                        controller: _nameController,
                        labelText: ToDoConstants.titleTxt,
                        isShowed: false,
                        isPassword: false,
                        isInLogInScreen: false,
                      ),
                      SpacingBoxWidget(height: 20),
                      TextFormFieldWidget(
                        controller: _noteController,
                        labelText: ToDoConstants.noteTxt,
                        isShowed: false,
                        isPassword: false,
                        isInLogInScreen: false,
                      ),
                      SpacingBoxWidget(height: 20),
                      Text(
                       ToDoConstants.setTimeTxt,
                        style: ThemeText.titleStyle
                      ),
                      SpacingBoxWidget(height: 10),
                      InkWell(
                        onTap: () => _selectTimePicker(),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                  color:AppColor.personalScheduleColor2,
                                  width: ToDoConstants.borderWidth)),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: ToDoConstants.setTimeContainerPaddingVertical),
                          child: Text(
                            state.selectTimer != null
                                ? '${state.selectTimer}'
                                : '',
                            style: ThemeText.labelStyle.copyWith(fontSize:ToDoConstants.timeFontSize,fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SpacingBoxWidget(height: 30),
                      state is TodoLoadingState
                          ? Container(
                              child: LoadingWidget(
                              ),
                            )
                          : GestureDetector(
                              onTap: () => _setOnClickSaveButton(state),
                              child:Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:AppColor.personalScheduleColor2,
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
                                padding:const EdgeInsets.symmetric(
                                    vertical: ToDoConstants.setTimeContainerPaddingVertical),
                                child: Text(
                                  ToDoConstants.saveTxt,
                                  style:
                                  ThemeText.titleStyle.copyWith( color: AppColor.secondColor,),
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
    DateTime? date = await showRoundedDatePicker(
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
    TimeOfDay? timer = await showRoundedTimePicker(
        context: context, initialTime: TimeOfDay.now(), borderRadius: 20);
    BlocProvider.of<TodoBloc>(context)
      ..add(SelectTimePickerOnPressEvent(timer: timer));
  }

  _setOnClickSaveButton(TodoState state) {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState!.validate()) {
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