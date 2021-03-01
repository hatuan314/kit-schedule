import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/src/blocs/blocs.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';
import 'package:schedule/src/utils/utils.dart';
import 'package:toast/toast.dart';

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
      backgroundColor: Colors.blue[900],
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            Navigator.pushReplacementNamed(context, '/home');
          }
          if (state is RegisterFailureState)
            Toast.show('Connection Failed', context,
                backgroundColor: Colors.red, textColor: Colors.white);
          if (state is RegisterNoDataState)
            Toast.show('No Data. Try again', context,
                backgroundColor: Colors.red, textColor: Colors.white);
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
                            top: ScUtil.getInstance().setHeight(20)),
                        elevation: 10,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.grey[100]),
                          padding: EdgeInsets.only(
                              left: ScUtil.getInstance().setWidth(20),
                              top: ScUtil.getInstance().setHeight(40),
                              right: ScUtil.getInstance().setWidth(20),
                              bottom: ScUtil.getInstance().setHeight(20)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'KIT Schedule',
                                style: TextStyle(
                                    fontSize: ScUtil.getInstance().setSp(40),
                                    color: Colors.blue[900],
                                    fontFamily: 'MR',
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: ScUtil.getInstance().setHeight(30),
                              ),
                              TextFormField(
                                controller: _accountController,
                                style: TextStyle(
                                    color: Colors.blue[800],
                                    fontSize: ScUtil.getInstance().setSp(32),
                                    fontFamily: "MR"),
                                cursorColor: Colors.blue[800],
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                        fontSize:
                                            ScUtil.getInstance().setSp(24),
                                        color: Colors.redAccent,
                                        fontFamily: "MR"),
                                    errorMaxLines: 2,
                                    labelText: 'KMA Account',
                                    labelStyle: TextStyle(
                                        fontSize:
                                            ScUtil.getInstance().setSp(32),
                                        color: Colors.blue[800],
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "MR"),
                                    prefixIcon: Icon(Icons.account_circle,
                                        color: Colors.blue[800]),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue[800],
                                            width: ScUtil.getInstance()
                                                .setWidth(3)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.redAccent,
                                            width: ScUtil.getInstance()
                                                .setWidth(3)),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8.0))),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[800], width: ScUtil.getInstance().setWidth(3)), borderRadius: BorderRadius.all(Radius.circular(8.0)))),
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
                              Stack(
                                alignment: AlignmentDirectional.centerEnd,
                                children: <Widget>[
                                  TextFormField(
                                    controller: _passwordController,
                                    style: TextStyle(
                                        color: Colors.blue[800],
                                        fontSize:
                                            ScUtil.getInstance().setSp(32),
                                        fontFamily: "MR"),
                                    cursorColor: Colors.blue[800],
                                    obscureText: !isShow,
                                    decoration: InputDecoration(
                                        errorStyle: TextStyle(
                                            fontSize:
                                                ScUtil.getInstance().setSp(24),
                                            color: Colors.redAccent,
                                            fontFamily: "MR"),
                                        errorMaxLines: 2,
                                        labelText: 'Password',
                                        labelStyle: TextStyle(
                                            fontSize:
                                                ScUtil.getInstance().setSp(32),
                                            color: Colors.blue[800],
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "MR"),
                                        prefixIcon: Icon(Icons.lock,
                                            color: Colors.blue[800]),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue[800],
                                                width: ScUtil.getInstance()
                                                    .setWidth(3)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0))),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.redAccent,
                                                width: ScUtil.getInstance()
                                                    .setWidth(3)),
                                            borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[800], width: ScUtil.getInstance().setWidth(3)), borderRadius: BorderRadius.all(Radius.circular(8.0)))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Trường này không được bỏ trống";
                                      }
                                      return null;
                                    },
//                                  onChanged: (value) => model.password = value,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      isShow
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.blue[800],
                                    ),
                                    onPressed: () =>
                                        BlocProvider.of<RegisterBloc>(context)
                                          ..add(ShowPasswordOnPress(
                                              isShow ? false : true)),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: ScUtil.getInstance().setHeight(30),
                              ),
                              state is RegisterLoadingState
                                  ? _loadingUI(state)
                                  : RaisedButton(
                                      color: Colors.blue[800],
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      textColor: Colors.white,
                                      onPressed: () =>
                                          _setOnClickLoginButton(state),
                                      child: Text(
                                        "LOGIN",
                                        style: TextStyle(
                                            fontSize:
                                                ScUtil.getInstance().setSp(34),
                                            fontFamily: 'MR',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: ScUtil.getInstance().setWidth(110),
                        padding: EdgeInsets.all(11),
                        decoration: new BoxDecoration(
                            border: Border.all(
                                color: Colors.blue[900],
                                width: ScUtil.getInstance().setWidth(8)),
                            shape: BoxShape.circle,
                            color: Colors.grey[100]),
                        child: Image.asset(
                          'assets/img/kit_schedule_logo.png',
                          fit: BoxFit.cover,
                          width: ScUtil.getInstance().setWidth(50),
                        ),
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
    if (_textFormKey.currentState.validate()) {
      BlocProvider.of<RegisterBloc>(context)
        ..add(SignInOnPressEvent(_accountController.text.toUpperCase().trim(),
            _passwordController.text.trim()));
    }
  }
}
