import 'package:flutter/material.dart';
import 'package:my_app/screens/homepage/view/homepage_screen.dart';
import 'package:my_app/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Future checkIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _token = prefs.getString("token");
    print(_token);
    print("TOKEN:");
    if (_token == null || _token == "") {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => new LoginPage()));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomepagePage()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//      decoration: BoxDecoration(
//        image: DecorationImage(
//          image: AssetImage('assets/images/football-boy.jpg'),
//          fit: BoxFit.cover,
//        ),
//      ),
      color: Colors.transparent,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 150.0,
              ),
              Container(
                padding: EdgeInsets.all(20),
                height: 250,
                child: Image.asset('assets/images/app-logo.png'),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
