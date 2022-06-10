import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
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
  void ContinueSong(String url) {
    _isNext = true;
    _numbersong += 1;

    audioPlayer.onPlayerCompletion.listen((event) async {
      PlaySong(url);
    });
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
