import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_countdown_timer/index.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CountdownTimerController controller;
  int endTime = DateTime.now().millisecondsSinceEpoch +
      Duration(days: 0, hours: 1, seconds: 30).inMilliseconds;

  @override
  void initState() {
    super.initState();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  void onEnd() {
    print('onEnd');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFF8A961),
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
              height: 100,
            ),
            Expanded(child: BottomWidget()),
          ],
        ),
      ),
    );
  }

  Widget successOrFailure(bool status) {
    if (status) {
      return Text(
        "success",
        style: GoogleFonts.montserrat(fontSize: 25, color: Colors.green),
        textAlign: TextAlign.center,
      );
    } else {
      return Text(
        "failure",
        style: GoogleFonts.montserrat(fontSize: 25, color: Colors.red),
        textAlign: TextAlign.center,
      );
    }
  }

  Widget TopWidget() {
    // return Text("koff", style: GoogleFonts.montserrat(fontSize: 55));
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Positioned(
                top: 0.0,
                right: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new IconButton(
                      icon: Icon(
                        Icons.account_circle,
                        size: 45,
                        color: Colors.white,
                      ),
                      onPressed: () {}),
                ),
              ),
              SizedBox(
                width: 80,
              ),
              Text(
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
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Hey there!",
            style: GoogleFonts.montserrat(
              fontSize: 55,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your last test was a ",
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
                  width: 100,
                  height: 30,
                  child: Center(child: successOrFailure(false)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 28,
              ),
              Text(
                "Age:",
                style:
                    GoogleFonts.montserrat(fontSize: 25, color: Colors.white),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "24",
                style:
                    GoogleFonts.montserrat(fontSize: 25, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 28,
              ),
              Text(
                "Country:",
                style:
                    GoogleFonts.montserrat(fontSize: 25, color: Colors.white),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Australia",
                style:
                    GoogleFonts.montserrat(fontSize: 25, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 28,
              ),
              Text(
                "Last test was at:",
                style:
                    GoogleFonts.montserrat(fontSize: 25, color: Colors.white),
              ),
            ],
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 28,
              ),
              Text(
                "Feb 24, 5:49 pm",
                style:
                    GoogleFonts.montserrat(fontSize: 25, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget BottomWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(60.0)),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text("Your next test is in",
                style: GoogleFonts.montserrat(fontSize: 30)),
            SizedBox(
              height: 30,
            ),
            CountdownTimer(
              // textStyle: GoogleFonts.montserrat(fontSize: 60),
              widgetBuilder: (_, CurrentRemainingTime time) {
                if (time == null) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Color(0xFFF1F1F1),
                              width: 70,
                              height: 70,
                              child: Center(
                                child: Text(
                                  "00",
                                  style: GoogleFonts.montserrat(fontSize: 35),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Text("hours", style: GoogleFonts.montserrat())
                        ],
                      ),

                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Color(0xFFF1F1F1),
                              width: 70,
                              height: 70,
                              child: Center(
                                child: Text(
                                  "00",
                                  style: GoogleFonts.montserrat(fontSize: 35),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Text("minutes", style: GoogleFonts.montserrat())
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      // Text(
                      //   ":",
                      //   style: GoogleFonts.montserrat(fontSize: 50),
                      // ),
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Color(0xFFF1F1F1),
                              width: 70,
                              height: 70,
                              child: Center(
                                child: Text(
                                  "00",
                                  style: GoogleFonts.montserrat(fontSize: 35),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Text("seconds", style: GoogleFonts.montserrat())
                        ],
                      ),
                    ],
                  );
                }
                // return Text(
                //     'days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Color(0xFFF1F1F1),
                            width: 70,
                            height: 70,
                            child: Center(
                              child: Text(
                                time.hours != null
                                    ? time.hours.toString()
                                    : "00",
                                style: GoogleFonts.montserrat(
                                  fontSize: 35,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Text("hours",
                            style: GoogleFonts.montserrat(
                                color: Color(0xFFF8A961)))
                      ],
                    ),

                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Color(0xFFF1F1F1),
                            width: 70,
                            height: 70,
                            child: Center(
                              child: Text(
                                time.min != null ? time.min.toString() : "00",
                                style: GoogleFonts.montserrat(fontSize: 35),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Text("minutes",
                            style: GoogleFonts.montserrat(
                                color: Color(0xFFF8A961)))
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    // Text(
                    //   ":",
                    //   style: GoogleFonts.montserrat(fontSize: 50),
                    // ),
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Color(0xFFF1F1F1),
                            width: 70,
                            height: 70,
                            child: Center(
                              child: Text(
                                time.sec != null ? time.sec.toString() : "00",
                                style: GoogleFonts.montserrat(fontSize: 35),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Text("seconds",
                            style: GoogleFonts.montserrat(
                                color: Color(0xFFF8A961)))
                      ],
                    ),
                  ],
                );
              },
              onEnd: onEnd,
              endTime: endTime,
            ),
          ],
        ),
      ),
    );
  }
}
