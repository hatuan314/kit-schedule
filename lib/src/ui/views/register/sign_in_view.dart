import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/src/blocs/blocs.dart';
import 'package:schedule/src/ui/views/widgets_constants/spacing_box_widget.dart';
import '../widgets_constants/text_form_field_widget.dart';
import '../widgets_constants/widgets_constants.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';
import 'package:schedule/src/utils/utils.dart';
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
      backgroundColor: ThemeColor.signInColor,
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
                            top: ScUtil.getInstance()!.setHeight(20)),
                        elevation: 10,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.grey[100]),
                          padding: EdgeInsets.only(
                              left: ScUtil.getInstance()!.setWidth(20),
                              top: ScUtil.getInstance()!.setHeight(40),
                              right: ScUtil.getInstance()!.setWidth(20),
                              bottom: ScUtil.getInstance()!.setHeight(20)),
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
                                      color: ThemeColor.personalScheduleColor,
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
                                  : RaisedButton(
                                      color: ThemeColor.personalScheduleColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      textColor: Colors.white,
                                      onPressed: () =>
                                          _setOnClickLoginButton(state),
                                      child: Text(
                                        "LOGIN",
                                        style:ThemeText.titleStyle.copyWith( fontSize:
                                        ScUtil.getInstance()!.setSp(34),) ,
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: ScUtil.getInstance()!.setWidth(110),
                        padding: EdgeInsets.all(11),
                        decoration: new BoxDecoration(
                            border: Border.all(
                                color: ThemeColor.signInColor,
                                width: ScUtil.getInstance()!.setWidth(8)),
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
