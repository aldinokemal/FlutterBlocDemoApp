import 'dart:io';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/screens/login/bloc/login_bloc.dart';
import 'package:my_app/screens/login/login.dart';
import 'package:my_app/config/theme.dart';
import 'package:my_app/screens/register/view/register_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:my_app/widget/changeLanguage.dart';
import 'package:my_app/widget/bezierContainer.dart';

class LoginContent extends StatefulWidget {
  LoginContent({Key? key}) : super(key: key);

  @override
  _LoginContentState createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  bool passwordVisible = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final _formKey = GlobalKey<FormState>();

    Widget _logo() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: Container(width: 100, height: 100, child: Image.asset('assets/images/app-logo.png')),
        ),
      );
    }

    Widget _inputEmail() {
      return BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {},
        builder: (context, loginState) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tr('AUTH_ACCOUNT_ID'),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    validator: (value) {
                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);
                      if (value.isEmpty) {
                        return tr("AUTH_ACCOUNT_ID_REQUIRED");
                      } else if (!emailValid) {
                        return tr("AUTH_ACCOUNT_ID_INVALID");
                      }
                      return null;
                    },
                    controller: _emailController,
                    onChanged: (data) => context.read<LoginBloc>().add(LoginEmailChanged(email: data)),
                    obscureText: false,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                        hintText: 'account@gmail.com'))
              ],
            ),
          );
        },
      );
    }

    Widget _inputPassword() {
      return BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    tr('AUTH_PASSWORD'),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return tr('AUTH_PASSWORD_REQUIRED');
                      }
                      return null;
                    },
                    obscureText: !passwordVisible,
                    // initialValue: state.password,
                    onChanged: (data) => context.read<LoginBloc>().add(LoginPasswordChanged(password: data)),
                    decoration: InputDecoration(
                      suffixIcon: new GestureDetector(
                        onTap: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        child: new Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                      ),
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                      hintText: '*****',
                    ),
                  ),
                ],
              ),
            );
          });
    }

    Widget _submitButton() {
      return TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<LoginBloc>().add(const LoginSubmitted());
              // Navigator.pushReplacementNamed(context, '/homepage');
            }
          },
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            padding: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)
                ],
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xff00569E), Color(0xff002e6f)])),
            child: Text(
              tr('AUTH_LOGIN'),
              style: TextStyle(fontSize: 20, color: Colors.white, letterSpacing: .5),
            ),
          ));
    }

    Widget _divider() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                ),
              ),
            ),
            Text(
              tr('GLOBAL_OR'),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      );
    }

    Widget _googleButton() {
      return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return TextButton(
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            onPressed: () {
              if (!state.status.isSubmissionInProgress) {
                context.read<LoginBloc>().add(LoginWithGoogle());
                EasyLoading.showInfo("Login with Google");
              }
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff7f0000),
                          // color: Colors.black12,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
                        ),
                        alignment: Alignment.center,
                        // child: Text(
                        //   'G',
                        //   style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
                        // ),
                        child: Image.asset('assets/images/google-icon.png', width: 30)),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffb71c1c),
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
                      ),
                      alignment: Alignment.center,
                      child: Text(tr('AUTH_LOGIN_GOOGLE'),
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400)),
                    ),
                  ),
                ],
              ),
            ));
      });
    }

    Widget _appleButton() {
      if (Platform.isIOS) {
        return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          return TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () {
                if (!state.status.isSubmissionInProgress) {
                  EasyLoading.showInfo("Login with Apple");
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
                          ),
                          alignment: Alignment.center,
                          child: Image.asset('assets/images/apple.png', width: 30)
                        // child: Text(
                        //   'A',
                        //   style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
                        // ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
                        ),
                        alignment: Alignment.center,
                        child: Text(tr('AUTH_LOGIN_APPLE'),
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ],
                ),
              ));
        });
      } else {
        return SizedBox();
      }
    }

    Widget _createAccountLabel() {
      return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return InkWell(
          onTap: () {
            if (!state.status.isSubmissionInProgress) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
            }
          },
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 20),
            padding: EdgeInsets.all(15),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  tr('AUTH_DONT_HAVE_ACC'),
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  tr('AUTH_REGISTER'),
                  style: TextStyle(color: AppTheme.main1, fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        );
      });
    }

    Widget _switchLanguage() {
      return Padding(padding: EdgeInsets.symmetric(vertical: 10), child: ChangeLanguage());
    }

    // List<Widget> _oauthButton() {
    //   var list = new List<Widget>.empty();
    //   if (Platform.isAndroid) {
    //     list.add(_googleButton());
    //   } else {
    //     // return _appleButton();
    //     list.add(_appleButton());
    //   }
    //   return list;
    // }

    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state.status.isSubmissionFailure) {
        EasyLoading.dismiss();
        EasyLoading.showError(state.message);
      } else if (state.status.isSubmissionSuccess) {
        EasyLoading.dismiss();
        EasyLoading.showInfo("Login Success");
        Navigator.pushReplacementNamed(context, '/homepage');
      } else if (state.status.isSubmissionInProgress) {
        EasyLoading.show(status: 'loading...');
        // EasyLoading.showProgress(100);
      } else {
        EasyLoading.dismiss();
      }
    }, builder: (context, state) {
      return Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(top: -height * .15, right: -MediaQuery
                .of(context)
                .size
                .width * .4, child: BezierContainer()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .05),
                    _logo(),
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          _inputEmail(),
                          _inputPassword(),
                          // _emailPasswordWidget(),
                          SizedBox(height: 20),
                          _submitButton(),
                        ],
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () =>
                          {
                            if (!state.status.isSubmissionInProgress)
                              {Navigator.pushNamed(context, '/forget-password')},
                          },
                          child: Text(
                            tr('AUTH_FORGET'),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.main2,
                            ),
                          ),
                        )),
                    _divider(),
                    SizedBox(height: 20),
                    _googleButton(),
                    SizedBox(height: 10),
                    _appleButton(),
                    SizedBox(height: height * .055),
                    _createAccountLabel(),
                    _switchLanguage()
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
