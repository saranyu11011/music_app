import 'package:app_music/music_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class Player extends StatefulWidget {
  Player({
    Key? key,
  }) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;

  var data = {
    0: {
      "name": "And So It Begins",
      "artist": "Artificial.Music ",
      "img": "https://wallpaperaccess.com/full/1959300.jpg",
      "url":
          "https://www.chosic.com/wp-content/uploads/2021/04/And-So-It-Begins-Inspired-By-Crush-Sometimes.mp3"
    },
    1: {
      "name": "Morning Routine",
      "artist": "Ghostrifter Official",
      "img": "https://wallpaperaccess.com/full/3033986.jpg",
      "url":
          "https://www.chosic.com/wp-content/uploads/2021/09/Morning-Routine-Lofi-Study-Music.mp3"
    },
    2: {
      "name": "Still Awake",
      "artist": "Ghostrifter Official",
      "img": "https://wallpaperaccess.com/full/3815055.jpg",
      "url":
          "https://www.chosic.com/wp-content/uploads/2021/09/Still-Awake-Lofi-Study-Music.mp3"
    },
    3: {
      "name": "Missing You",
      "artist": "Purrple Cat",
      "img": "https://wallpaperaccess.com/full/946034.png",
      "url": "https://www.chosic.com/wp-content/uploads/2022/01/Missing-You.mp3"
    },
    4: {
      "name": "Don’t Forget",
      "artist": "Spheriá",
      "img": "https://wallpaperaccess.com/full/3815059.jpg",
      "url":
          "https://www.chosic.com/wp-content/uploads/2022/01/Dont-Forget-Me.mp3"
    },
    5: {
      "name": "After the Rain",
      "artist": "Keys of Moon",
      "img": "https://wallpaperaccess.com/full/1422010.png",
      "url":
          "https://www.chosic.com/wp-content/uploads/2022/04/After-the-Rain-Inspiring-Atmospheric-Music.mp3"
    },
  };
  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    late double height = 110;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
                height: 80,
                width: 1000,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 0, top: 30),
                          child: Text(
                            "Music",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.black38,
                width: 500,
                height: 400,
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          // String url = "${data[index]!["url"]}";
                          // await audioPlayer.play(url);

                          context.read<Counter>().setNumber(index);
                          context
                              .read<Counter>()
                              .PlaySong('${data[index]!["url"]}');
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black12,
                          ),
                          child: ListTile(
                            leading: Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.only(left: 0, right: 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.red,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "${data[index]!["img"]}"))),
                            ),
                            title: Text(
                              'Song : ${data[index]!["name"]}',
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Artist : ${data[index]!["artist"]}',
                              style: TextStyle(color: Colors.white),
                            ),
                            //trailing: Text('${data[index]!["artist"]}'),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return [
    if (duration.inHours > 0) hours,
    minutes,
    seconds,
  ].join(":");
}
