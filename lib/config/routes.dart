import 'package:flutter/material.dart';
import 'package:my_app/screens/homepage/view/homepage_screen.dart';
import 'package:my_app/screens/login/login.dart';
import 'package:my_app/screens/register/register.dart';
import 'package:my_app/widget/splashScreen.dart';

var appRoutes = <String, WidgetBuilder>{
  '/splash': (context) => SplashScreenPage(),
  '/login': (context) => LoginPage(),
  '/register': (context) => RegisterPage(),
  '/homepage': (context) => HomepagePage(),
};
