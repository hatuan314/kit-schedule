
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/blocs/register/register_bloc.dart';
import 'package:schedule/presentation/journey/register/sign_in_constants.dart';
import 'package:schedule/presentation/journey/register/widgets/app_bar_widget.dart';
import 'package:schedule/presentation/widget/text_form_field.dart';
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
          body: Container(
            margin: EdgeInsets.symmetric(
                horizontal: SignInConstants.horizontalScreen), //sẽ bị lỗi do chưa có thư viện /// fix xong, chỉ cần làm lần đầu với các file
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                        LoginTextField(
                          textController: _accountController,
                          labelText: SignInConstants.accountTxt,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        LoginTextField(
                          showPassWordBtn:state is RegisterLoadingState ?
                              (){}:() {

                            BlocProvider.of<RegisterBloc>(context)
                                .add(ShowPasswordOnPress(!isShow));
                          },
                          textController: _passwordController,
                          labelText: SignInConstants.passwordTxt,
                          obscureText: isShow,
                        ),
                      ],
                    )),
                SizedBox(
                  height: SignInConstants.paddingEnd,
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
              height: SignInConstants.heightLoginBtn,
              width: SignInConstants.widthLoginBtn,
              decoration: BoxDecoration(
                  color: SignInConstants.colorDefault,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: state is RegisterLoadingState
                  ? _loadingUI()
                  : Icon(
                Icons.arrow_forward_rounded,
                size: SignInConstants.sizeIconContinue,
                color: Colors.white,
              ),
            ),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.miniEndDocked,
          bottomNavigationBar: Container(
            height: SignInConstants.heightBottomBar,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.3),
          ),
        );
      },
    );
  }

  _loadingUI() {
    return Container(
      child: LoadingWidget(),
    );
  }

  Future _setOnClickLoginButton(RegisterState state) async {
    if (_textFormKey.currentState!.validate()) {
      BlocProvider.of<RegisterBloc>(context)
        ..add(SignInOnPressEvent(_accountController.text.toUpperCase().trim(),
            _passwordController.text.trim()));
    }
  }
}

