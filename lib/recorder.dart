import 'dart:async';

import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audio_wave/audio_wave.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class RecorderScreen extends StatefulWidget {
  //RecorderScreen({Key key}) : super(key: key);
  // LocalFileSystem localFileSystem;
  //RecorderScreen({localFileSystem})
  //    : this.localFileSystem = localFileSystem ?? LocalFileSystem();
  @override
  _RecorderScreenState createState() => _RecorderScreenState();
}

class _RecorderScreenState extends State<RecorderScreen> {
  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;

  initRecorder() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = await getExternalStorageDirectory();
        }

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();

        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder =
            FlutterAudioRecorder(customPath, audioFormat: AudioFormat.WAV);

        await _recorder.initialized;
        // after initialization
        var current = await _recorder.current(channel: 0);
        print(current);
        // should be "Initialized", if all working fine
        setState(() {
          _current = current;
          _currentStatus = current.status;
          print(_currentStatus);
        });
        await startRecording();
      } else {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }

  startRecording() async {
    try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      setState(() {
        _current = recording;
      });

      const tick = const Duration(milliseconds: 50);
      new Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder.current(channel: 0);
        // print(current.status);
        setState(() {
          _current = current;
          _currentStatus = _current.status;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  stopRecording() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    var vertifyUrl = "https://koff-backend.ratemycourse.review/verify";
    var result = await _recorder.stop();
    var audioFilePath = result.path;
    print("Stop recording: ${result.path}");
    print("Stop recording: ${result.duration}");
    String fileName = audioFilePath.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(audioFilePath, filename: fileName),
      "token": token
    });
    Dio dio = new Dio();
    Toast.show("Uploading...", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    var response = await dio.post(vertifyUrl, data: formData);
    print(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      const tick = const Duration(milliseconds: 500);
      Toast.show("Uploaded", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      new Timer.periodic(tick, (Timer t) async {
        t.cancel();
        Navigator.pushNamed(context, "/home");
      });
      print("Uploaded!");
    }
    setState(() {
      _current = result;
      _currentStatus = _current.status;
    });
  }

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  Widget build(BuildContext context) {
    //_requestTempDirectory();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFF8A961),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: topWidget()),
            // CenterWidget(),
            SizedBox(
              height: 100,
            ),
            Expanded(child: bottomWidget()),
          ],
        ),
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: new InkWell(
          onTap: () {
            stopRecording();
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

  Widget topWidget() {
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

  Widget bottomWidget() {
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
