import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web/config/palette.dart';
import 'package:web/screens/login/log_screen.dart';
import 'package:web/screens/login/loginForm.dart';
import 'package:web/screens/screens.dart';

main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {



  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLogedIn;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogedIn = false;
    _checkSession();
  }

  _checkSession(){

    if(box. hasData("token"))
      {_isLogedIn = true;}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CatchMeOn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Palette.scaffold,
      ),
      home: _isLogedIn? NavScreen(): AuthThreePage(),
    );
  }
}
