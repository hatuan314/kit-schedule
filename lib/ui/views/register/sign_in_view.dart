import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/blocs/blocs.dart';
import 'package:schedule/ui/views/widgets/spacing_box_widget.dart';
import 'package:schedule/ui/views/widgets/text_form_field_widget.dart';
import 'package:schedule/ui/views/widgets/widgets_constants.dart';
import 'package:schedule/utils/utils.dart';
//import 'package:toast/toast.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  GlobalKey<FormState> _textFormKey = GlobalKey<FormState>();
  TextEditingController _accountController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColor.signInColor,
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            Navigator.pushReplacementNamed(context, '/home');
          }
          if (state is RegisterFailureState) {
            /*Toast.show('Connection Failed', context,
                backgroundColor: Colors.red, textColor: Colors.white);*/
          }
          if (state is RegisterNoDataState) {
            /*Toast.show('No Data. Try again', context,
                backgroundColor: Colors.red, textColor: Colors.white);*/
          }
        },
        child:
            BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
          bool isShow = false;
          if (state is RegisterShowPasswordState) {
            isShow = state.isShow;
          }
          return Form(
            key: _textFormKey,
            child: Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(20)),
                        elevation: 10,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.grey[100]),
                          padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(20),
                              top: ScreenUtil().setHeight(40),
                              right: ScreenUtil().setWidth(20),
                              bottom: ScreenUtil().setHeight(20)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'KIT Schedule',
                                style: ThemeText.headerStyle2
                              ),
                          SpacingBoxWidget(height: 30),
                             TextFormFieldWidget(controller: _accountController, labelText: 'Account', isShowed: isShow, isPassword: false,isInLogInScreen: true,),
                              SpacingBoxWidget(height: 20),
                              Stack(
                                alignment: AlignmentDirectional.centerEnd,
                                children: <Widget>[
                                  TextFormFieldWidget(controller: _passwordController, labelText: 'Password', isShowed: isShow, isPassword: true,isInLogInScreen: true,),
                                  IconButton(
                                    icon: Icon(
                                      isShow
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: AppColor.personalScheduleColor,
                                    ),
                                    onPressed: () =>
                                        BlocProvider.of<RegisterBloc>(context)
                                          ..add(ShowPasswordOnPress(
                                              isShow ? false : true)),
                                  )
                                ],
                              ),
                              SpacingBoxWidget(height: 30),
                              state is RegisterLoadingState
                                  ? _loadingUI(state)
                                  : GestureDetector(
                                     // color: AppColor.personalScheduleColor,

                                     // textColor: Colors.white,
                                      onTap: () =>
                                          _setOnClickLoginButton(state),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
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
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                                          child: Text(
                                            "LOGIN",
                                            style:ThemeText.titleStyle.copyWith( fontSize:
                                            ScreenUtil().setSp(34),
                                            color: AppColor.secondColor) ,
                                          ),
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(110),
                        padding: EdgeInsets.all(11),
                        decoration: new BoxDecoration(
                            border: Border.all(
                                color: AppColor.signInColor,
                                width: ScreenUtil().setWidth(8)),
                            shape: BoxShape.circle,
                            color: Colors.grey[100]),
                        child: WidgetsConstants().kitLogo
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  _loadingUI(RegisterState state) {
    return Container(
      child: LoadingWidget(color: Colors.blue,),
    );
  }

  Future _setOnClickLoginButton(RegisterState state) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_textFormKey.currentState!.validate()) {
      BlocProvider.of<RegisterBloc>(context)
        ..add(SignInOnPressEvent(_accountController.text.toUpperCase().trim(),
            _passwordController.text.trim()));
    }
  }
}
