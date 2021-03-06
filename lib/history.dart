import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //backgroundColor: Color(0xFFF8A961),
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text("koff", style: GoogleFonts.montserrat(fontSize: 55)),
      //   backgroundColor: Colors.transparent,
      //   centerTitle: true,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: TopWidget()),
            // CenterWidget(),
            SizedBox(
              height: 300,
            ),
            Expanded(child: BottomWidget()),
          ],
        ),
      ),
    );
  }

  Widget TopWidget() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Positioned(
                top: 0.0,
                //right: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new IconButton(
                      icon: Icon(
                        Icons.account_circle,
                        size: 45,
                        color: Color(0xFFF8A961),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      }),
                ),
              ),
              // SizedBox(
              //   width: 80,
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget BottomWidget() {
    return ClipRRect(
      //borderRadius: BorderRadius.vertical(top: Radius.circular(60.0)),
      child: Container(
        color: Colors.black,
        width: 500,
        height: 100,
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Color(0xFFFDEAD9),
                width: 300,
                height: 100,
                child: Center(
                  child: Text(
                    "Authenticate",
                    style: GoogleFonts.montserrat(
                        fontSize: 25, color: Color(0xFFF8A961)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
