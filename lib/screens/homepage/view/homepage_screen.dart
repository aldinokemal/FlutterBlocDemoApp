import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomepagePage extends StatefulWidget {
  HomepagePage({Key? key}) : super(key: key);

  @override
  _HomepagePageState createState() => _HomepagePageState();
}

class _HomepagePageState extends State<HomepagePage> {
  void logut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");

    Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: TextButton(onPressed: () async => {logut()}, child: Text("Logout")),
        //   child: Column(
        // children: [
        //   Text("wadwaw"),
        //   TextButton(onPressed: () => {Navigator.pushNamed(context, '/login')}, child: Text("Go To"))
        // ],
      ),
    ));
  }
}
