import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tweet_ui/embedded_tweet_view.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_api/twitter_api.dart';
import 'package:web/config/palette.dart';
import 'package:web/data/data.dart';
import 'package:web/screens/homeYoutube/youtube_screen_mobile.dart';
import 'package:web/widgets/widgets.dart';


class HomeScreenYoutube extends StatefulWidget {
  @override
  _HomeScreenYoutubeState createState() => _HomeScreenYoutubeState();
}

class _HomeScreenYoutubeState extends State<HomeScreenYoutube> {
  final TrackingScrollController _trackingScrollController =
  TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Responsive(
            mobile:
            HomeScreenYoutubeMobile (scrollController: _trackingScrollController),
            desktop:
            Scaffold(),
          ),
        ),
      );


  }
}

