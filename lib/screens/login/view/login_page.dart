// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:my_app/screens/login/login.dart';
// import 'package:easy_localization/easy_localization.dart';
//
// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     context.setLocale(Locale("en"));
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(title: Text('APP_NAME').tr()),
//       body: BlocProvider(
//         create: (context) {
//           return LoginBloc();
//         },
//         child: LoginForm(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:my_app/screens/login/login.dart';
import 'package:my_app/screens/login/view/login_content.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoginContent());
  }
}
