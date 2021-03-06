import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List model = [{}, {}, {}];
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
            // SizedBox(
            //   height: 300,
            // ),
            // Expanded(child: BottomWidget()),
          ],
        ),
      ),
      floatingActionButton: ClipRRect(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                //top: 0.0,
                //right: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new IconButton(
                    icon: Icon(
                      Icons.account_circle,
                      size: 60,
                      color: Color(0xFFF8A961),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          new GestureDetector(
            onTap: () {
              Toast.show("Copied to clipboard!", context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            },
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your Unique ID: ",
                  style: GoogleFonts.montserrat(
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  width: 1,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Color(0xFFF1F1F1),
                    width: 500,
                    height: 30,
                    child: Center(
                      child: Text(
                        "VSBOWUV73RGFUWQ7FSD",
                        style: GoogleFonts.montserrat(
                            fontSize: 25, color: Colors.green),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Tap to copy",
                  style: GoogleFonts.montserrat(color: Color(0xFFF8A961)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          _myListView(context),
        ],
      ),
    );
  }

  Widget _myListView(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
        //padding: const EdgeInsets.all(5.0),
        height: 400,
        width: 500,
        // decoration: BoxDecoration(
        //   border: Border.all(
        //     width: 4,
        //     // color: EqualistColors.lightGreen,
        //   ),
        // ), //       <--- BoxDecoration here
        child: ListView.builder(
          itemCount: model.length,
          itemBuilder: (context, index) {
            return listItem(context, index);
          },
        ));
  }

  Widget listItem(BuildContext context, int index) {
    return Card(
      child: Row(
        children: <Widget>[
          Container(margin: EdgeInsets.all(10), child: Text("1")),
          Container(
            height: 20,
            width: 1,
            color: Colors.blue,
          ),
          Container(margin: EdgeInsets.all(10), child: Text("asdasd")),
          SizedBox(
            height: 50,
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
