import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tweet_ui/embedded_tweet_view.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_webview/tweet_webview.dart';
import 'package:web/config/palette.dart';
import 'package:web/data/data.dart';
import 'package:web/models/models.dart';
import 'package:web/screens/login/logscreen.dart';
import 'package:web/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:web/screens/login/loginForm.dart';

import 'package:web/utilities/keys.dart';

class HomeScreenTweetsnMobile extends StatelessWidget {
  final TrackingScrollController scrollController;
  final List listId = [
    "1351507304697520129",
    "1351521894080671744",
    "1351233814190829572"
  ];

  HomeScreenTweetsnMobile({Key key, @required this.scrollController})
      : super(key: key);

var tweet ;
     Future<dynamic> loadTweetJSON(String id) async {
      String  token = "Bearer "+box.read("token");

      var Url = "http://localhost:8080/getTweetFromUser?userTwetterId=1351521894080671744";
      var response = await http.get(
        Url,
       headers:  <String, String>{
          "Content-Type": "application/json",
          /*"Authorization": token,*/
        }, ) ;
      print( response.body.toString());

      if (response.statusCode == 200) {
        String responseString = response.body;
        box.write("tweet1", responseString.toString());
      }

    }



  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Text(
            "CatchMeOn",
            style: const TextStyle(
              color: Palette.catchMeOn_logo_Color,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2,
            ),
          ),
          centerTitle: false,
          floating: true,
          //avatar Image

          actions: [
            CircleButton(
              icon: Icons.search,
              iconSize: 30.0,
              onPressed: () => print('search'),
            ),
            CircleButton(
              icon: MdiIcons.instagram,
              iconSize: 30.0,
              onPressed: () => print('instagram'),
            ),
            CircleButton(
              icon: MdiIcons.twitter,
              iconSize: 30.0,
              onPressed: () => print('twitter'),
            ),
            CircleButton(
              icon: MdiIcons.logout,
              iconSize: 30.0,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthThreePage()),
              ),
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            loadTweetJSON("1351233814190829572");
            print(tweet);
            return EmbeddedTweetView.fromTweet(
                Tweet.fromRawJson(box.read("tweet1")));
          },
          childCount: 1),
        ),
      ],
    );
  }
}
