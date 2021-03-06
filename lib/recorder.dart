import 'dart:async';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audio_wave/audio_wave.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/services.dart';

class RecorderScreen extends StatefulWidget {
  RecorderScreen({Key key}) : super(key: key);

  @override
  _RecorderScreenState createState() => _RecorderScreenState();
}

class _RecorderScreenState extends State<RecorderScreen> {
  LocalFileSystem localFileSystem;
  File recordingFile;
  var recordingItem;
  var recorderItem;

  initRecorder() async {
    bool hasPermission = await FlutterAudioRecorder.hasPermissions;
    print(hasPermission);
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    print(tempPath);
    var recorder = FlutterAudioRecorder(tempPath, audioFormat: AudioFormat.WAV);
    await recorder.initialized;
    setState(() {
      recorderItem = recorder;
    });
    startRecording(recorder);
  }

  startRecording(var recorder) async {
    await recorder.start();
    var recording = await recorder.current(channel: 0);
  }

  stopRecording() async {
    var result = await recorderItem.stop();
    //File file = widget.localFileSystem.file(result.path);
  }

  @override
  void initState() {
    initRecorder();
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
              height: 100,
            ),
            Expanded(child: BottomWidget()),
          ],
        ),
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: new InkWell(
          onTap: () {
            print("yo recording stopped");
          },
          child: Container(
            color: Color(0xFFFDEAD9),
            width: 100,
            height: 50,
            child: Center(
              child: Text(
                "Done",
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
            height: 150,
          ),
          Text(
            "Cough Now!",
            style: GoogleFonts.montserrat(
              fontSize: 55,
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
