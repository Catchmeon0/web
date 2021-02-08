import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web/models/UserModel.dart';
import 'package:web/screens/homeYoutube/youtube_screen_desktop.dart';
import 'package:web/screens/homeYoutube/youtube_screen_mobile.dart';
import 'package:web/screens/login/loginForm.dart';
import 'package:web/services/database_service.dart';
import 'package:web/widgets/widgets.dart';

class HomeMainScreenYoutube extends StatefulWidget {
  @override
  _HomeMainScreenYoutube createState() => _HomeMainScreenYoutube();
}

class _HomeMainScreenYoutube extends State<HomeMainScreenYoutube> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  UserModel _user;

  @override
  void initState() {
    super.initState();
    _getCurrentUserInfo();
  }

  _getCurrentUserInfo() async {
    UserModel user =
        await DatabaseService().currentUser(box.read("currentUserId"));

    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: HomeScreenYoutubeMobile(
            scrollController: _trackingScrollController,
            currentUser: _user,
          ),
          desktop: HomeScreenYoutubeDesktop(
              scrollController: _trackingScrollController),
        ),
      ),
    );
  }
}
