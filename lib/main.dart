import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web/config/palette.dart';
import 'package:web/screens/login/log_screen.dart';
import 'package:web/screens/screens.dart';

main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CatchMeOn UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Palette.scaffold,
      ),
      home: AuthThreePage(),
    );
  }
}
