import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class checkingPage extends StatefulWidget {
  checkingPage({Key key}) : super(key: key);

  @override
  _checkingPageState createState() => _checkingPageState();
}

class _checkingPageState extends State<checkingPage> {
  void checkState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token != "") {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: new AssetImage("assets/loadingfinal.gif"),
            ),
          ],
        ),
      ),
    );
  }
}
