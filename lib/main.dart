import 'package:flutter/services.dart';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AssetsAudioPlayer player = new AssetsAudioPlayer();
  bool play = false;
  int element = 0;
  bool loopActive = false;
  List<String> songs = [
    "5.opus",
    "8.opus",
    "9.opus",
    "1.mp3",
    "2.mp3",
    "3.mp3",
  ];

  List<Map<String, dynamic>> songDetais = [
    { "image":'15.jpg', "song":"1.mp3"},
    { "image":'7.jpg', "song":"1.mp3"},
    { "image":'9.jpg', "song":"1.mp3"}
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    // color: Colors.amber,
                    image: DecorationImage(
                        image: AssetImage(
                          'images/15.jpg',
                        ),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(110),
                      bottomRight: Radius.circular(110),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text('${songDetais.elementAt(element)["song"]}'),
              // Text('${play}'),
              Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: Column(
                      children: songs.map((e) => Song(e, '10:30')).toList(),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    // color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          child: IconButton(
                              icon: Icon(Icons.shuffle),
                              onPressed: () {
                                print('object');
                              }),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(
                                    Icons.arrow_left,
                                  ),
                                  iconSize: 40,
                                  // iconSize: 50,
                                  onPressed: () {
                                    setState(() {
                                      if (element <= 0) {
                                        element = 0;
                                      } else {
                                        play = false;
                                        player.pause();
                                        element -= 1;
                                        play = true;
                                        player.open(
                                          Audio(
                                              "music/${songs.elementAt(element)}"),
                                        );
                                      }
                                    });
                                  }),
                              IconButton(
                                  color: Colors.black,
                                  icon: play == false
                                      ? Icon(
                                          Icons.play_arrow,
                                        )
                                      : Icon(Icons.pause, size: 25),
                                  iconSize: 50,
                                  onPressed: () {
                                    setState(() {
                                      if (element <= 0 &&
                                          element >= songs.length) {
                                      } else {
                                        play = !play;
                                      }
                                    });
                                    if (play == false) {
                                      player.pause();
                                    } else {
                                      player.open(
                                        Audio(
                                            "music/${songs.elementAt(element)}"),
                                      );
                                    }
                                  }),
                              IconButton(
                                  icon: Icon(Icons.arrow_right),
                                  iconSize: 40,
                                  onPressed: () {
                                    setState(() {
                                      if (element >= songs.length) {
                                        element = songs.length;
                                      } else {
                                        play = false;
                                        player.pause();
                                        element += 1;
                                        play = true;
                                        player.open(
                                          Audio(
                                              "music/${songs.elementAt(element)}"),
                                        );
                                      }
                                    });
                                  }),
                            ],
                          ),
                        ),
                        Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.repeat,
                                color: loopActive == true
                                    ? Colors.greenAccent
                                    : Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  loopActive = !loopActive;
                                });
                              }),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget Song(name, duration) {
  return Container(
    height: 50,
    margin: EdgeInsets.only(top: 5),
    // color: Colors.blue[50],
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text('${name}'),
        Text('${duration}'),
      ],
    ),
  );
}
