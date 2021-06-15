import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
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
  TextEditingController _emailControlller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
        listener: (context, state) {
          if (state.email == "") {
            _emailControlller.text = state.email;
          }
        },
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
                    controller: _emailControlller,
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
      return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
        if (state.password == "") {
          _passwordController.text = state.password;
        }
      }, builder: (context, state) {
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
                      hintText: '*****'))
            ],
          ),
        );
      });

      // return BlocBuilder<LoginBloc, LoginState>(builder: (context, loginState) {
      //   return Container(
      //     margin: EdgeInsets.symmetric(vertical: 10),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: <Widget>[
      //         Text(
      //           tr('AUTH_PASSWORD'),
      //           style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         TextFormField(
      //             // key: UniqueKey(),
      //             validator: (value) {
      //               if (value == null || value.isEmpty) {
      //                 return tr('AUTH_PASSWORD_REQUIRED');
      //               }
      //               return null;
      //             },
      //             obscureText: !passwordVisible,
      //             initialValue: loginState.password,
      //             onChanged: (data) => context.read<LoginBloc>().add(LoginPasswordChanged(password: data)),
      //             decoration: InputDecoration(
      //                 suffixIcon: new GestureDetector(
      //                   onTap: () {
      //                     setState(() {
      //                       passwordVisible = !passwordVisible;
      //                     });
      //                   },
      //                   child: new Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
      //                 ),
      //                 border: InputBorder.none,
      //                 fillColor: Color(0xfff3f3f4),
      //                 filled: true,
      //                 hintText: '*****'))
      //       ],
      //     ),
      //   );
      // });
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
            width: MediaQuery.of(context).size.width,
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
      return TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () {
            print("login with Google");
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
                      color: Color(0xff8e0000),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'G',
                      style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffc62828),
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
    }

    Widget _createAccountLabel() {
      return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
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
    }

    Widget _switchLanguage() {
      return Padding(padding: EdgeInsets.symmetric(vertical: 10), child: ChangeLanguage());
    }

    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status != "") {
            EasyLoading.showInfo("Login Success");
            // ScaffoldMessenger.of(context)
            //   ..hideCurrentSnackBar()
            //   ..showSnackBar(
            //     const SnackBar(content: Text('Authentication Failure')),
            //   );
          }
        },
        child: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(top: -height * .15, right: -MediaQuery.of(context).size.width * .4, child: BezierContainer()),
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
                          )),
                      Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => {Navigator.pushNamed(context, '/forget-password')},
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
                      SizedBox(height: height * .055),
                      _createAccountLabel(),
                      _switchLanguage()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
