import 'dart:convert';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koff/colors.dart';
import 'package:koff/home.dart';
import 'package:koff/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:uuid/uuid.dart';
//import 'gallery.dart';
import 'main.dart';
//import 'package:toast/toast.dart';
import 'package:http/http.dart';

class SignupPage extends StatefulWidget {
  static String tag = 'Signup-page';
  @override
  _SignupPageState createState() => new _SignupPageState();
}

final ageController = TextEditingController();
final passwordController = TextEditingController();
final reppasswordController = TextEditingController();

class _SignupPageState extends State<SignupPage> {
  _Signup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uuid = Uuid();
    print(uuid.v4().toString());
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

    final age = TextField(
      controller: ageController,
      keyboardType: TextInputType.number,
      autofocus: false,
      //initialValue: '',
      decoration: InputDecoration(
        hintText: 'Age',
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
        hintText: 'New Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final repeatpassword = TextField(
      controller: reppasswordController,
      autofocus: false,
      //initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Repeat New Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final SignupButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          _Signup();

          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //   builder: (context) => GalleryDemo(),
          // ));
        },
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: Text('Register for koff',
            style: TextStyle(color: ColorsClass.mainYellow)),
      ),
    );
    final signupButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          _Signup();

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
        },
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: Text('Login instead',
            style: TextStyle(color: ColorsClass.mainYellow)),
      ),
    );

    final logoLabel = Text(
      "koff",
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
        fontSize: 55,
        color: Colors.white,
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
      'Signup',
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
            age,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 8.0),
            repeatpassword,
            SizedBox(height: 24.0),
            SignupButton,
            // SizedBox(height: 5.0),
            signupButton,
          ],
        ),
      ),
    );
  }
}
