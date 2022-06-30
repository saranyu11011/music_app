import 'package:app_music/music_list.dart';
import 'package:app_music/music_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/src/provider.dart';

class MiniPlayerMusic extends StatefulWidget {
  MiniPlayerMusic({Key? key, required this.index}) : super(key: key);
  int index;
  @override
  State<MiniPlayerMusic> createState() => _MiniPlayerMusicState();
}

class _MiniPlayerMusicState extends State<MiniPlayerMusic> {
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
    // context.read<Counter>().ContinueSong(widget.index);
    // context
    //     .read<Counter>()
    //     .audioPlayer
    //     .onPlayerCompletion
    //     .listen((event) async {
    //   setState(() {
    //     context.read<Counter>().setNumber(widget.index++);
    //     context.read<Counter>().ContinueSong('${data[widget.index++]!["url"]}');
    //   });
    // });
    // audioPlayer.onPlayerStateChanged.listen((state) {
    context.read<Counter>().audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });
    context.read<Counter>().audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    context
        .read<Counter>()
        .audioPlayer
        .onAudioPositionChanged
        .listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    IconData btnIcon = context.read<Counter>().btnIcon;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Stack(
          children: <Widget>[
            //MiniPlayerMusic(),
            Player(),
            Miniplayer(
              minHeight: 170,
              maxHeight: 660,
              builder: (height, percentage) {
                return height <= 200
                    ? SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: (15),
                            horizontal: (15),
                          ),
                          // height: 174,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            // boxShadow: [
                            //   BoxShadow(
                            //       // offset: const Offset(-10, -15),
                            //       //blurRadius: 20,
                            //       // color: Color(0xFFDADADA).withOpacity(0.9),
                            //       )
                            // ],
                          ),
                          child: SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      child: IconButton(
                                        icon: Icon(Icons.skip_previous),
                                        iconSize: 20,
                                        onPressed: () async {
                                          if (widget.index == 0) {
                                            context
                                                .read<Counter>()
                                                .setNumber(5);
                                            context
                                                .read<Counter>()
                                                .PlaySong('${data[5]!["url"]}');
                                          } else {
                                            context
                                                .read<Counter>()
                                                .setNumber(widget.index - 1);
                                            context.read<Counter>().PlaySong(
                                                '${data[widget.index - 1]!["url"]}');
                                          }
                                        },
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 20,
                                      child: IconButton(
                                        icon: Icon(btnIcon),
                                        iconSize: 20,
                                        onPressed: () async {
                                          if (context.read<Counter>().isPlay) {
                                            setState(() {
                                              btnIcon = Icons.play_arrow;
                                            });
                                          } else {
                                            setState(() {
                                              btnIcon = Icons.pause;
                                            });
                                          }
                                          if (context.read<Counter>().isPlay) {
                                            //print('when pause $isPlaying');
                                            // isPlaying = true;

                                            context
                                                .read<Counter>()
                                                .PlaySong('pause');
                                            isPlaying = false;
                                          } else {
                                            // print('when resume $isPlaying');

                                            context.read<Counter>().PlaySong(
                                                '${data[widget.index]!["url"]}');
                                            isPlaying = true;
                                          }
                                          // if (isPlaying) {
                                          //   await audioPlayer.pause();
                                          // } else {
                                          //   String url =
                                          //       "${data[widget.index]!["url"]}";
                                          //   await audioPlayer.play(url);
                                          // }

                                          // if (context.read<Counter>().isPlay) {
                                          //   await audioPlayer.pause();
                                          // } else {
                                          //   //start with false will go here
                                          //   if (context.read<Counter>().isPlay) {
                                          //     await audioPlayer.pause();
                                          //   } else {
                                          //     String url =
                                          //         "${data[context.read<Counter>().numbersong]!["url"]}";
                                          //     await audioPlayer.play(url);
                                          //   }
                                          // }
                                        },
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 20,
                                      child: IconButton(
                                        icon: Icon(Icons.skip_next),
                                        iconSize: 20,
                                        onPressed: () async {
                                          context
                                              .read<Counter>()
                                              .setNumber(widget.index + 1);
                                          print('index is ${widget.index + 1}');
                                          if (widget.index + 1 == 6) {
                                            context
                                                .read<Counter>()
                                                .setNumber(0);
                                            context
                                                .read<Counter>()
                                                .PlaySong('${data[0]!["url"]}');
                                          } else {
                                            context.read<Counter>().PlaySong(
                                                '${data[widget.index + 1]!["url"]}');
                                          }
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      height: 60,
                                      margin: const EdgeInsets.only(
                                          left: 0, right: 0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.red,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "${data[widget.index]!["img"]}"))),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("${data[widget.index]!["name"]}")
                                      ],
                                    ),
                                    Slider(
                                        min: 0,
                                        max: duration.inSeconds.toDouble(),
                                        value: position.inSeconds.toDouble(),
                                        onChanged: (value) async {
                                          final position =
                                              Duration(seconds: value.toInt());
                                          await context
                                              .read<Counter>()
                                              .audioPlayer
                                              .seek(position);

                                          await context
                                              .read<Counter>()
                                              .audioPlayer
                                              .resume();
                                        }),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(formatTime(position)),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          Text(formatTime(duration - position))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 0),
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
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 0, top: 30),
                                        child: Text(
                                          "${data[widget.index]!["name"]}",
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
                            InkWell(
                              onTap: () {
                                print("${position.inSeconds.toDouble()}");
                              },
                              child: Container(
                                width: 300,
                                height: 250,
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.red,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "${data[widget.index]!["img"]}"))),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${data[widget.index]!["name"]}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${data[widget.index]!["artist"]}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            Slider(
                                min: 0,
                                max: duration.inSeconds.toDouble(),
                                value: position.inSeconds.toDouble(),
                                onChanged: (value) async {
                                  final position =
                                      Duration(seconds: value.toInt());
                                  await context
                                      .read<Counter>()
                                      .audioPlayer
                                      .seek(position);

                                  await context
                                      .read<Counter>()
                                      .audioPlayer
                                      .resume();
                                }),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(formatTime(position)),
                                  Text(formatTime(duration - position))
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  child: IconButton(
                                    icon: Icon(Icons.skip_previous),
                                    iconSize: 40,
                                    onPressed: () async {
                                      if (widget.index == 0) {
                                        context
                                            .read<Counter>()
                                            .setNumber(data.length - 1);
                                        context.read<Counter>().PlaySong(
                                            '${data[data.length - 1]!["url"]}');
                                      } else {
                                        context
                                            .read<Counter>()
                                            .setNumber(widget.index - 1);
                                        context.read<Counter>().PlaySong(
                                            '${data[widget.index - 1]!["url"]}');
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  child: IconButton(
                                    icon: Icon(btnIcon),
                                    iconSize: 40,
                                    onPressed: () async {
                                      if (context.read<Counter>().isPlay) {
                                        setState(() {
                                          btnIcon = Icons.play_arrow;
                                        });
                                      } else {
                                        setState(() {
                                          btnIcon = Icons.pause;
                                        });
                                      }
                                      if (context.read<Counter>().isPlay) {
                                        //print('when pause $isPlaying');
                                        // isPlaying = true;

                                        context
                                            .read<Counter>()
                                            .PlaySong('pause');
                                        isPlaying = false;
                                      } else {
                                        // print('when resume $isPlaying');

                                        context.read<Counter>().PlaySong(
                                            '${data[widget.index]!["url"]}');
                                        isPlaying = true;
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  child: IconButton(
                                    icon: Icon(Icons.skip_next),
                                    iconSize: 40,
                                    onPressed: () async {
                                      if (widget.index == data.length - 1) {
                                        context.read<Counter>().setNumber(0);
                                        context
                                            .read<Counter>()
                                            .PlaySong('${data[0]!["url"]}');
                                      } else {
                                        context
                                            .read<Counter>()
                                            .setNumber(widget.index + 1);
                                        context.read<Counter>().PlaySong(
                                            '${data[widget.index + 1]!["url"]}');
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        context.read<Counter>().RepeatSong();
                                      },
                                      icon: Icon(Icons.repeat_one),
                                      color: context.read<Counter>().isLoop
                                          ? Colors.blue
                                          : Colors.black),
                                  // IconButton(
                                  //   onPressed: () {
                                  //     // context
                                  //     //     .read<Counter>()
                                  //     //     .setNumber(widget.index + 1);
                                  //
                                  //     context
                                  //         .read<Counter>()
                                  //         .ContinueSong(widget.index);
                                  //
                                  //     // context.read<Counter>().ContinueSong(
                                  //     //     '${data[widget.index + 3]!["url"]}');
                                  //   },
                                  //   icon: Icon(Icons.repeat),
                                  //   color: context.read<Counter>().isNext
                                  //       ? Colors.blue
                                  //       : Colors.black,
                                  // )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
              },
            ),
          ],
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
