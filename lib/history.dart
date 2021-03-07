import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koff/main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List model = [
    {
      "timestamp": "2021-03-07T00:02:28+00:00",
      "result": false,
      "blockID": "loading"
    },
    {
      "timestamp": "2021-03-06T23:34:06+00:00",
      "result": false,
      "blockID": "loading"
    },
    {
      "timestamp": "2021-03-06T23:20:23+00:00",
      "result": false,
      "blockID": "loading"
    }
  ];

  String uniqueid = "loading";

  void getHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    String endpoint = MyApp.endpoint + "/history/" + token;
    var response = await http.get(endpoint);
    final List parsed = json.decode(response.body);
    print(parsed);
    String uuid = prefs.getString("uuid");
    setState(() {
      model = parsed;
      uniqueid = uuid;
    });
  }

  @override
  void initState() {
    getHistory();
    super.initState();
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

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
        child: new InkWell(
          onTap: () {
            qrScan();
          },
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
              Clipboard.setData(new ClipboardData(text: uniqueid));
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
                        uniqueid,
                        style: GoogleFonts.montserrat(
                            fontSize: 15, color: Colors.green),
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
    String st = "";
    if (model[index]["result"]) {
      st = "Success";
    } else {
      st = "Failure";
    }
    DateTime dateTime = DateTime.parse(model[index]["timestamp"]);
    String lastTestTime = dateTime.day.toString() +
        "/" +
        dateTime.month.toString() +
        "/" +
        dateTime.year.toString();
    return Card(
      child: InkWell(
        onTap: () {
          _launchURL(
              "https://rinkeby.etherscan.io/tx/" + model[index]["blockID"]);
        }, // Handle your callback
        child: Row(
          children: <Widget>[
            Container(margin: EdgeInsets.all(10), child: Text(st)),
            Container(
              height: 20,
              width: 3,
              color: Color(0xFFFDEAD9),
            ),
            Container(margin: EdgeInsets.all(10), child: Text(lastTestTime)),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  qrpostreq() async {
    Navigator.pop(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    String endpoint = MyApp.endpoint + "/add-to-queue/" + token;
    var response = await http.get(endpoint);
    print(response.body);
    Alert(
      context: context,
      type: AlertType.success,
      title: "Success",
      desc: "Authentication succesfull",
      buttons: [
        DialogButton(
          child: Text(
            "Done",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          width: 120,
        )
      ],
    ).show();
  }

  Future qrScan() async {
    String cameraScanResult = await scanner.scan();
    print(cameraScanResult);
    if (cameraScanResult != "") {
      Alert(
        context: context,
        type: AlertType.warning,
        title: "Authentication",
        desc: "Share your koff history for verification to " +
            cameraScanResult +
            " ?",
        buttons: [
          DialogButton(
            child: Text(
              "Agree",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => qrpostreq(),
            color: Color.fromRGBO(0, 179, 134, 1.0),
          ),
          DialogButton(
            child: Text(
              "Disagree",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: Color.fromRGBO(0, 179, 134, 1.0),
          )
        ],
      ).show();
    }
  }
}
