import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web/screens/homeYoutube/youtube_screen_desktop.dart';
import 'package:web/screens/homeYoutube/youtube_screen_mobile.dart';
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: HomeScreenYoutubeMobile(
              scrollController: _trackingScrollController),
          desktop: HomeScreenYoutubeDesktop(
              scrollController: _trackingScrollController),
        ),
      ),
    );
  }
}
