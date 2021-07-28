import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/blocs/register/register_bloc.dart';
import 'package:schedule/presentation/journey/register/sign_in_constants.dart';
import 'package:schedule/presentation/journey/register/widgets/app_bar_widget.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/presentation/widget/text_field_widget/text_field_widget.dart';
import 'package:schedule/presentation/widget/loading_widget/loading_widget.dart';

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
          // Toast.show('Connection Failed', context,
          //     backgroundColor: Colors.red, textColor: Colors.white);
        }
        if (state is RegisterNoDataState) {
          // Toast.show('No Data. Try again', context,
          //     backgroundColor: Colors.red, textColor: Colors.white);
        }
      },
      builder: (context, state) {
        bool isShow = true;
        if (state is RegisterShowPasswordState) {
          isShow = state.isShow;
        }
        return Scaffold(
            appBar: AppBarWidget(),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SignInConstants
                        .horizontalScreen), //sẽ bị lỗi do chưa có thư viện /// fix xong, chỉ cần làm lần đầu với các file
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 120.h,
                    ),
                    Text(
                      SignInConstants.welcomeTxt,
                      style: SignInConstants.textStyleTxt
                          .copyWith(fontSize: SignInConstants.sizeWelcomeTxt),
                    ),
                    Text(
                      SignInConstants.kitScheduleTxt,
                      style: SignInConstants.textStyleTxt.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: SignInConstants.sizeKitScheduleTxt),
                    ),
                    SizedBox(
                      height: SignInConstants.paddingTextToTextFiled,

                      /// chỉ cần gõ 65.h
                    ),
                    Form(
                        key: _textFormKey,
                        child: Column(
                          children: [
                            TextFieldWidget(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Trường này không được bỏ trống";
                                }
                                return null;
                              },
                              labelText: SignInConstants.accountTxt,
                              controller: _accountController,
                              textStyle: ThemeText.labelStyle,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            TextFieldWidget(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Trường này không được bỏ trống";
                                }
                                return null;
                              },
                              labelText: SignInConstants.passwordTxt,
                              controller: _passwordController,
                              textStyle: ThemeText.labelStyle,
                              obscureText: isShow,
                              seffixIcon: IconButton(
                                onPressed: state is RegisterLoadingState
                                    ? () {}
                                    : () {
                                        BlocProvider.of<RegisterBloc>(context)
                                            .add(ShowPasswordOnPress(!isShow));
                                      },
                                icon: Icon(
                                  isShow
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: SignInConstants.colorDefault,
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: SignInConstants.paddingEnd,
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
                height: 90.h,
                width: double.infinity,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: SignInConstants.heightBottomBar,
                        width: double.infinity,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    Positioned(
                      right: 20.h,
                      child: GestureDetector(
                        onTap: state is RegisterLoadingState
                            ? null
                            : () {
                                _setOnClickLoginButton(state);
                              },
                        child: Container(
                          height: SignInConstants.heightLoginBtn,
                          width: SignInConstants.widthLoginBtn,
                          decoration: BoxDecoration(
                              color: SignInConstants.colorDefault,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: state is RegisterLoadingState
                              ? _loadingUI()
                              : Icon(
                                  Icons.arrow_forward_rounded,
                                  size: SignInConstants.sizeIconContinue,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    )
                  ],
                )));
      },
    );
  }

  _loadingUI() {
    return Container(
      child: LoadingWidget(),
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
