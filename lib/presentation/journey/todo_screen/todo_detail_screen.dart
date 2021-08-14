import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:schedule/presentation/journey/todo_screen/bloc/todo_bloc.dart';
import 'package:schedule/presentation/journey/todo_screen/todo_constants.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/models/model.dart';
import 'package:schedule/presentation/widget/loading_widget/loading_widget.dart';
import 'package:schedule/presentation/widget/spacing_box_widget.dart';
import 'package:schedule/presentation/widget/text_form_field_widget.dart';
//import 'package:toast/toast.dart';

class TodoDetailView extends StatefulWidget {
  final PersonalSchedule? schedule;

  const TodoDetailView({Key? key, this.schedule}) : super(key: key);

  @override
  _TodoDetailViewState createState() => _TodoDetailViewState();
}

class _TodoDetailViewState extends State<TodoDetailView> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = this.widget.schedule!.name!;
    _noteController.text = this.widget.schedule!.note!;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is TodoSuccessState) {
          /*Toast.show('Update Success', context,
              backgroundColor: Colors.green, textColor: Colors.white);*/
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is TodoFailureState) {
          // Toast.show('UPdate Failed', context,
          //     backgroundColor: Colors.red, textColor: Colors.white);
        }
      },
      child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.personalScheduleColor2,
          appBar: AppBar(
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
            child: Column(
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
            ),
          ),
        );
      }),
    );
  }

  _todoBackgroundWidget(TodoState state) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: ToDoConstants.paddingHorizontal),
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
                  '${this.widget.schedule!.name}',
                  style: ThemeText.headerStyle,
                ),
              ),
              InkWell(
                onTap: () => _selectDatePicker(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
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
                        state is TodoInitState
                            ? '${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(int.parse(this.widget.schedule!.date!)))}'
                            : state.selectDay != null
                                ? '${DateFormat.yMd().format(DateTime.fromMillisecondsSinceEpoch(int.parse(state.selectDay!)))}'
                                : '',
                        style:ThemeText.textInforStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: ToDoConstants.paddingHorizontal),
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
                color: AppColor.secondColor,
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
                        labelText:ToDoConstants.titleTxt,
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
                          padding: EdgeInsets.symmetric(
                              vertical: ToDoConstants.setTimeContainerPaddingVertical),
                          child: Text(
                            state is TodoInitState
                                ? '${this.widget.schedule!.timer}'
                                : state.selectTimer != null
                                    ? '${state.selectTimer}'
                                    : '',
                            style: ThemeText.titleStyle
                        ),
                      ),
                      ),
                      SpacingBoxWidget(height: 30),
                      state is TodoLoadingState
                          ? Container(
                              child: LoadingWidget(),
                            )
                          : ElevatedButton(
                              onPressed: () => _setOnClickUpdateButton(state),

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
                                width: double.infinity,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    vertical: ToDoConstants.setTimeContainerPaddingVertical),
                                child: Text(
                                    ToDoConstants.saveTxt,
                                  style: ThemeText.buttonLabelStyle
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
      imageHeader: AssetImage("assets/img/calendar-header-todo-detail.jpg"),
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

  _setOnClickUpdateButton(TodoState state) {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<TodoBloc>(context)
        ..add(UpdatePersonalScheduleOnPressEvent(this.widget.schedule!.id,
            _nameController.text.trim(), _noteController.text.trim()));
    }
  }

  _waitingDeleteDialog() {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: ToDoConstants.paddingVertical),
          child: RichText(
            text: TextSpan(
                text: ToDoConstants.confirmDeleteTxt,
                style:ThemeText.titleStyle.copyWith(color: Colors.black54,
                    fontWeight: FontWeight.normal),
                children: [
                  TextSpan(
                      text: ToDoConstants.confirmDeleteTxt2,
                      style: ThemeText.titleStyle.copyWith(color: AppColor.errorColor, )),
                  TextSpan(
                      text: '${this.widget.schedule!.name}?',
                      style: ThemeText.titleStyle.copyWith(color: Colors.black54,
                          fontWeight: FontWeight.normal),),
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
              padding:  EdgeInsets.symmetric(
                  vertical: ToDoConstants.paddingVertical,
                  horizontal: ToDoConstants.paddingHorizontal
              ),
              child: Text(
                ToDoConstants.yesTxt,
                style: ThemeText.buttonLabelStyle.copyWith(
                    color: AppColor.secondColor, fontWeight: FontWeight.bold),),
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
                  horizontal: ToDoConstants.paddingHorizontal
              ),
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
      ..add(DetelePersonalScheduleOnPressEvent(this.widget.schedule!.id));
  }
}
