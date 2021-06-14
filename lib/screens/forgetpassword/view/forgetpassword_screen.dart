

import 'package:flutter/material.dart';
import 'package:my_app/screens/forgetpassword/view/forgetpassword_content.dart';

class ForgetpasswordPage extends StatefulWidget {
  ForgetpasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetpasswordPageState createState() => _ForgetpasswordPageState();
}

class _ForgetpasswordPageState extends State<ForgetpasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ForgetpasswordContent());
  }
}