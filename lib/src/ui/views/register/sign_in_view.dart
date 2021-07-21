import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/src/blocs/blocs.dart';
import 'package:schedule/src/ui/views/register/sign_in_constains.dart';
import 'package:schedule/src/ui/views/register/widgets/text_form_flield.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';
import 'package:schedule/src/utils/utils.dart';
import 'package:toast/toast.dart';

import 'widgets/app_bar.dart';

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
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Navigator.pushReplacementNamed(context, '/home');
        }
        if (state is RegisterFailureState) {
          Toast.show('Connection Failed', context,
              backgroundColor: Colors.red, textColor: Colors.white);
        }
        if (state is RegisterNoDataState) {
          Toast.show('No Data. Try again', context,
              backgroundColor: Colors.red, textColor: Colors.white);
        }
      },
      builder: (context, state) {
        bool isShow = true;
        if (state is RegisterShowPasswordState) {
          isShow = state.isShow;
        }
        return Scaffold(
          appBar: AppBarWidget(),
          body: Container(
            margin: EdgeInsets.symmetric(
                horizontal: ScUtil.getInstance().setSp(50)),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to,",
                  style: SignInConstains.textStyleTxt
                      .copyWith(fontSize: SignInConstains.sizeWelcomeTxt),
                ),
                Text(
                  "Kit Schedule",
                  style: SignInConstains.textStyleTxt.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: SignInConstains.sizeKitScheduleTxt),
                ),
                SizedBox(
                  height: ScUtil.getInstance().setHeight(65),
                ),
                Form(
                    key: _textFormKey,
                    child: Column(
                      children: [
                        LoginTextField(
                          textController: _accountController,
                          labelText: 'Email address',
                        ),
                        SizedBox(
                          height: ScUtil.getInstance().setHeight(10),
                        ),
                        LoginTextField(
                          showPassWordBtn: state is RegisterLoadingState
                              ? null
                              : () {
                            BlocProvider.of<RegisterBloc>(context)
                              ..add(ShowPasswordOnPress(
                                  isShow ? false : true));
                          },
                          textController: _passwordController,
                          labelText: 'Password',
                          obscureText: isShow,
                        ),
                      ],
                    )),
                SizedBox(
                  height: ScUtil.getInstance().setHeight(90),
                )
              ],
            ),
          ),
          floatingActionButton: GestureDetector(
            onTap: state is RegisterLoadingState
                ? null
                : () {
              _setOnClickLoginButton(state);
            },
            child: Container(
              height: ScUtil.getInstance().setHeight(40),
              width: ScUtil.getInstance().setWidth(150),
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: state is RegisterLoadingState
                  ? _loadingUI(state)
                  : Icon(
                Icons.arrow_forward_rounded,
                size: ScUtil.getInstance().setSp(50),
                color: Colors.white,
              ),
            ),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.miniEndDocked,
          bottomNavigationBar: Container(
            height: ScUtil.getInstance().setHeight(50),
            width: double.infinity,
            color: Colors.grey.withOpacity(0.3),
          ),
        );
      },
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
