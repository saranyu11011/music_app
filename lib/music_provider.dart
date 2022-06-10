import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
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
  int _numbersong = 0;
  final audioPlayer = AudioPlayer();

  int get numbersong => _numbersong;

  bool _isPlay = false;

  bool get isPlay => _isPlay;
  IconData btnIcon = Icons.play_arrow;

  bool _isLoop = false;

  bool get isLoop => _isLoop;
  void setNumber(int index) {
    _isPlay = true;
    _numbersong = index;

    notifyListeners();
  }

  void RepeatSong() {
    if (_isLoop == false) {
      _isLoop = true;
      audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    } else if (_isLoop == true) {
      _isLoop = false;
      audioPlayer.setReleaseMode(ReleaseMode.RELEASE);
    }
  }

  bool _isNext = false;

  bool get isNext => _isNext;
  void ContinueSong(int index) {
    //audioPlayer.play('${data[index]!['url']}');
    if (_isNext == false) {
      _isNext = true;

      audioPlayer.onPlayerCompletion.listen((event) async {
        // PlaySong('${data[index + 1]!['url']}');
        if (_numbersong < data.length - 1) {
          print("it come here");
          setNumber(_numbersong += 1);
          print(_numbersong);
          //index += 1;
          //+1 beacuse next song then play next song
          audioPlayer.play('${data[_numbersong]!['url']}');
        } else if (_numbersong == data.length - 1) {
          //last song
          print("here");
          audioPlayer.pause();

          //set first song
          //setNumber(_numbersong = 0);
          // index -= 5;
          //audioPlayer.play('${data[0]!['url']}');
        }
      });
    } else {
      _isNext = false;

      audioPlayer.onPlayerCompletion.listen((event) async {
        // PlaySong('${data[index + 1]!['url']}');
        audioPlayer.pause();
      });
    }
  }

  String currentSong = '';
  void PlaySong(String url) async {
    if (_isPlay && url == 'pause') {
      audioPlayer.pause();
      print("pause");
      _isPlay = false;
      btnIcon = Icons.play_arrow;
      notifyListeners();
    }
    // if (_isPlay == false && url == 'resume') {
    //   audioPlayer.resume();
    //   print("resume");
    //   _isPlay = true;
    // }
    else if (_isPlay && currentSong != url) {
      print("play song");
      btnIcon = Icons.pause;

      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if (result == 1) {
        currentSong = url;
        _isPlay = true;
        notifyListeners();
      }
      notifyListeners();
    } else if (!_isPlay) {
      btnIcon = Icons.pause;

      print("resume");
      int result = await audioPlayer.play(url);
      if (result == 1) {
        _isPlay = true;
        notifyListeners();
      }
      notifyListeners();
    }
  }
}
