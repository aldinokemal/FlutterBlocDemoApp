import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/config/theme.dart';
import 'package:my_app/screens/forgetpassword/bloc/forgetpassword_bloc.dart';
import 'package:my_app/widget/bezierContainer.dart';
import 'package:my_app/widget/changeLanguage.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgetpasswordContent extends StatefulWidget {
  ForgetpasswordContent({Key? key}) : super(key: key);

  @override
  _ForgetpasswordContentState createState() => _ForgetpasswordContentState();
}

class _ForgetpasswordContentState extends State<ForgetpasswordContent> {
  Widget _logo() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: Container(width: 100, height: 100, child: Image.asset('assets/images/app-logo.png')),
      ),
    );
  }

  Widget _switchLanguage() {
    return Padding(padding: EdgeInsets.symmetric(vertical: 10), child: ChangeLanguage());
  }

  Widget _inputEmail() {
    return BlocBuilder<ForgetpasswordBloc, ForgetpasswordState>(
      builder: (context, forgetPasswordState) {
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
                  initialValue: forgetPasswordState.email,
                  onChanged: (data) => context.read<ForgetpasswordBloc>().add(ForgetpasswordEmailChanged(email: data)),
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

  Widget _submitButton() {
    return Container(
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
        tr('AUTH_RESET_NOW'),
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              tr('AUTH_BACK_TO'),
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 3,
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                  _inputEmail(),
                  SizedBox(
                    height: 20,
                  ),
                  _submitButton(),
                  SizedBox(height: height * .055),
                  _loginAccountLabel(),
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
