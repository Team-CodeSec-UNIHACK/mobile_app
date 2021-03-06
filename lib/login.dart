import 'dart:convert';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koff/colors.dart';
import 'package:koff/main.dart';
import 'package:koff/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  _login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String uuid = emailController.text.toString();
    String password = passwordController.text.toString();
    if (uuid != "" && password != "") {
      var reqbody = {"uuid": uuid, "password": password};
      String endpoint = MyApp.endpoint + "/login";
      var response = await http.post(endpoint, body: json.encode(reqbody));
      final Map parsed = json.decode(response.body);
      print(parsed);
      if (parsed["message"] == "success") {
        String token = parsed["token"];
        prefs.setString("token", token);
        prefs.setBool("verify", true);
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Toast.show("Login failed, please try again", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final logo = Hero(
    //   tag: 'hero',
    //   child: CircleAvatar(
    //     backgroundColor: Colors.transparent,
    //     radius: 48.0,
    //     child: Image.asset('images/logo.png'),
    //   ),
    // );

    final email = TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      //initialValue: '',
      decoration: InputDecoration(
        hintText: 'Unique - ID',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextField(
      controller: passwordController,
      autofocus: false,
      //initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          _login(context);

          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //   builder: (context) => GalleryDemo(),
          // ));
        },
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: Text('Log In', style: TextStyle(color: ColorsClass.mainYellow)),
      ),
    );
    final signupButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SignupPage(),
          ));
        },
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: Text('Using for the first time?',
            style: TextStyle(color: ColorsClass.mainYellow)),
      ),
    );

    final logoLabel = Text(
      "koff",
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
        fontSize: 55,
        color: ColorsClass.mainYellow,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(3.0, 3.0),
            blurRadius: 3.0,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          Shadow(
            offset: Offset(3.0, 3.0),
            blurRadius: 8.0,
            color: Colors.black,
          ),
        ],
      ),
    );

    // final logoLabel = Text(
    //   'koff',
    //   textAlign: TextAlign.center,
    //   overflow: TextOverflow.ellipsis,
    //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36.0),
    // );
    final belowlogoLabel = Text(
      'Login',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            // logo,
            SizedBox(height: 15.0),
            logoLabel,
            belowlogoLabel,
            SizedBox(height: 30.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            // SizedBox(height: 5.0),
            signupButton,
          ],
        ),
      ),
    );
  }
}
