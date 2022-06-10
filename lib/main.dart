import 'package:app_music/music_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mini_player_music.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => Counter()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          // body: HomePage(
          //   play: 0,
          //   positionn: Duration(
          //     seconds: 0,
          //   ),
          //   maxMin: Duration(
          //     seconds: 0,
          //   ),
          //   index: 0,
          // ),
          body: MiniPlayerMusic(index: context.watch<Counter>().numbersong),
        ));
  }
}
