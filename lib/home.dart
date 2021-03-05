import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("yo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: TopWidget()),
            // CenterWidget(),
            Expanded(child: BottomWidget()),
          ],
        ),
      ),
    );
  }

  Widget TopWidget() {
    return Text("hello");
  }

  Widget BottomWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        color: Colors.red,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
