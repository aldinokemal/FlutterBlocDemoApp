import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/config/theme.dart';
import 'package:my_app/screens/register/bloc/register_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:my_app/widget/bezierContainer.dart';
import 'package:my_app/widget/changeLanguage.dart';

class RegisterContent extends StatefulWidget {
  RegisterContent({Key? key}) : super(key: key);

  @override
  _RegisterContentState createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> {
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  Widget _logo() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: Container(width: 100, height: 100, child: Image.asset('assets/images/app-logo.png')),
      ),
    );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            context.read<RegisterBloc>().add(const RegisterSubmitted());
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
                  begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [AppTheme.main1, AppTheme.main2])),
          child: Text(
            tr('AUTH_REGISTER_NOW'),
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        // margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              tr('AUTH_HAVE_ACC'),
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              tr('AUTH_LOGIN'),
              style: TextStyle(color: AppTheme.main1, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputFullname() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              tr('AUTH_FULLNAME'),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr('AUTH_FULLNAME_REQUIRED');
                  }
                  return null;
                },
                obscureText: false,
                // initialValue: state.fullname,
                onChanged: (data) => context.read<RegisterBloc>().add(RegisterFullnameChanged(fullname: data)),
                decoration: InputDecoration(
                    border: InputBorder.none, fillColor: Color(0xfff3f3f4), filled: true, hintText: '*****'))
          ],
        ),
      );
    });
  }

  Widget _inputEmail() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
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
                    bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                    if (value.isEmpty) {
                      return tr("AUTH_ACCOUNT_ID_REQUIRED");
                    } else if (!emailValid) {
                      return tr("AUTH_ACCOUNT_ID_INVALID");
                    }
                    return null;
                  },
                  // initialValue: state.email,
                  onChanged: (data) => context.read<RegisterBloc>().add(RegisterEmailChanged(email: data)),
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
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return tr('AUTH_PASSWORD_REQUIRED');
                }
                return null;
              },
              obscureText: !passwordVisible,
              // initialValue: state.password,
              onChanged: (data) => context.read<RegisterBloc>().add(RegisterPasswordChanged(password: data)),
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

  Widget _switchLanguage() {
    return Padding(padding: EdgeInsets.symmetric(vertical: 10), child: ChangeLanguage());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<RegisterBloc, RegisterState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return (Scaffold(
            body: Container(
              height: height,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -MediaQuery.of(context).size.height * .15,
                    right: -MediaQuery.of(context).size.width * .4,
                    child: BezierContainer(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: height * .05),
                          _logo(),
                          SizedBox(
                            height: 50,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                _inputFullname(),
                                _inputEmail(),
                                _inputPassword(),
                                SizedBox(height: 20),
                                _submitButton(),
                              ],
                            ),
                          ),
                          SizedBox(height: height * .055),
                          _loginAccountLabel(),
                          _switchLanguage()
                        ],
                      ),
                    ),
                  ),
                  // Positioned(top: 40, left: 0, child: _backButton()),
                ],
              ),
            ),
          ));
        });
  }
}
