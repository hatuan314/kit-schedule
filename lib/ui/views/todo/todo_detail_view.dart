import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/blocs/todo/todo_bloc.dart';
import 'package:schedule/models/model.dart';
import 'package:schedule/ui/views/widgets/text_form_field_widget.dart';
import 'package:schedule/utils/utils.dart';
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
                    size: 24,
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
      padding:
          EdgeInsets.symmetric(horizontal: ScreenUtil()!.setWidth(50)),
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
                      vertical: ScreenUtil()!.setHeight(5)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/img/ic-calendar.svg',
                        color: AppColor.secondColor,
                        height: ScreenUtil()!.setHeight(18),
                      ),
                      SizedBox(
                        width: ScreenUtil()!.setWidth(18),
                      ),
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
            padding: EdgeInsets.only(right: ScreenUtil()!.setWidth(50)),
            child: SvgPicture.asset(
              'assets/img/kit_schedule_logo.svg',
              width: ScreenUtil()!.setHeight(60),
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
            padding: EdgeInsets.only(
                left: ScreenUtil()!.setWidth(50),
                top: ScreenUtil()!.setWidth(75),
                right: ScreenUtil()!.setWidth(50),
                bottom: ScreenUtil()!.setWidth(50)),
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormFieldWidget(
                        controller: _nameController,
                        labelText: 'Title',
                        isShowed: false,
                        isPassword: false,
                        isInLogInScreen: false,
                      ),
                      SizedBox(
                        height: ScreenUtil()!.setHeight(20),
                      ),
                      TextFormFieldWidget(
                        controller: _noteController,
                        labelText: 'Note',
                        isShowed: false,
                        isPassword: false,
                        isInLogInScreen: false,
                      ),
                      SizedBox(
                        height: ScreenUtil()!.setHeight(20),
                      ),
                      Text(
                        'Set time',
                        style: ThemeText.titleStyle.copyWith(fontSize: ScreenUtil().setSp(38))
                      ),
                      SizedBox(
                        height: ScreenUtil()!.setHeight(10),
                      ),
                      InkWell(
                        onTap: () => _selectTimePicker(),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                  color: AppColor.personalScheduleColor2,
                                  width: ScreenUtil()!.setWidth(3))),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil()!.setHeight(12)),
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
                      SizedBox(
                        height: ScreenUtil()!.setHeight(30),
                      ),
                      state is TodoLoadingState
                          ? Container(
                              child: LoadingWidget(
                                color: AppColor.fourthColor,
                                size: 40.0,
                              ),
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
                                    vertical:
                                        ScreenUtil()!.setHeight(12)),
                                child: Text(
                                  'Update',
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
              vertical: ScreenUtil()!.setHeight(20)),
          child: RichText(
            text: TextSpan(
                text: 'Do you want ',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: ScreenUtil()!.setSp(32),
                    fontFamily: 'MR',
                    fontWeight: FontWeight.normal),
                children: [
                  TextSpan(
                      text: 'delete ',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: ScreenUtil()!.setSp(32),
                          fontFamily: 'MR',
                          fontWeight: FontWeight.w600)),
                  TextSpan(
                      text: '${this.widget.schedule!.name}?',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: ScreenUtil()!.setSp(32),
                          fontFamily: 'MR',
                          fontWeight: FontWeight.normal)),
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
              padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
              child: Text('Yes (Y)',
                  style: TextStyle(
                      color: Color(0xffFCFAF3),
                      fontSize: ScreenUtil()!.setSp(32),
                      fontFamily: 'MR',
                      fontWeight: FontWeight.bold)),
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
              padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
              child: Text('No (N)',
                  style: TextStyle(
                      color: Color(0xffFCFAF3),
                      fontSize: ScreenUtil()!.setSp(32),
                      fontFamily: 'MR',
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
