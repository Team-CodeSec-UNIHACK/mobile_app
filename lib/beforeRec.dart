import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audio_wave/audio_wave.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BeforeRecorderScreen extends StatefulWidget {
  BeforeRecorderScreen({Key key}) : super(key: key);

  @override
  _BeforeRecorderScreenState createState() => _BeforeRecorderScreenState();
}

class _BeforeRecorderScreenState extends State<BeforeRecorderScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFF8A961),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: TopWidget()),
            // CenterWidget(),
            SizedBox(
              height: 90,
            ),
            Expanded(child: BottomWidget()),
          ],
        ),
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: new InkWell(
          onTap: () {
            Alert(
              context: context,
              type: AlertType.warning,
              title: "Remember!",
              desc:
                  "Recording begins after this, so please start coughing. Please make sure to record atleast 2 seconds of your cough sound before stopping",
              buttons: [
                DialogButton(
                  child: Text(
                    "Start",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, "/recorder"),
                  color: Color.fromRGBO(0, 179, 134, 1.0),
                ),
                DialogButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  color: Color.fromRGBO(0, 179, 134, 1.0),
                )
              ],
            ).show();
          },
          child: Container(
            color: Color(0xFFFDEAD9),
            width: 100,
            height: 50,
            child: Center(
              child: Text(
                "Next",
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
                      onPressed: () {
                        Navigator.pushNamed(context, '/history');
                      }),
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
            height: 40,
          ),
          Text(
            "In the next step, you will be providing koff with an audio sample of your cough.",
            style: GoogleFonts.montserrat(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Your Results will appear in the history tab after it has been added to the blockchain",
            style: GoogleFonts.montserrat(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Please Note: This is not a medical diagonois but simply a precautionary measure",
            style: GoogleFonts.montserrat(
              fontSize: 20,
            ),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            AudioWave(
              height: 200,
              width: 251,
              spacing: 2.5,
              animationLoop: 1,
              bars: [
                AudioWaveBar(height: 10, color: Colors.black),
                AudioWaveBar(height: 30, color: Colors.black),
                AudioWaveBar(height: 70, color: Colors.black),
                AudioWaveBar(height: 40, color: Colors.black),
                AudioWaveBar(height: 20, color: Colors.black),
                AudioWaveBar(height: 10, color: Colors.black),
                AudioWaveBar(height: 30, color: Colors.black),
                AudioWaveBar(height: 70, color: Colors.black),
                AudioWaveBar(height: 40, color: Colors.black),
                AudioWaveBar(height: 20, color: Colors.black),
                AudioWaveBar(height: 10, color: Colors.black),
                AudioWaveBar(height: 30, color: Colors.black),
                AudioWaveBar(height: 70, color: Colors.black),
                AudioWaveBar(height: 40, color: Colors.black),
                AudioWaveBar(height: 20, color: Colors.black),
                AudioWaveBar(height: 10, color: Colors.black),
                AudioWaveBar(height: 30, color: Colors.black),
                AudioWaveBar(height: 70, color: Colors.black),
                AudioWaveBar(height: 40, color: Colors.black),
                AudioWaveBar(height: 20, color: Colors.black),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
