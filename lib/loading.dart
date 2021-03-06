import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:koff/home.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key key, this.reqBody, this.audio}) : super(key: key);

  final reqBody;
  final File audio;
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  createPlaylist(var rqbdy) async {
    String endpoint = "Services.apiUrl" + "create-playlist/";
    var response = await http.post(endpoint, body: rqbdy);
    final Map parsed = json.decode(response.body);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var reqbody = widget.reqBody;
    createPlaylist(reqbody);
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
