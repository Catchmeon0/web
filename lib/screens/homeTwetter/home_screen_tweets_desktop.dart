import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tweet_ui/default_text_styles.dart';
import 'package:tweet_ui/embedded_tweet_view.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:web/config/palette.dart';
import 'package:web/screens/login/logscreen.dart';
import 'package:web/services/database_service.dart';
import 'package:web/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:web/screens/login/loginForm.dart';

class HomeScreenTweetsnDesktop extends StatefulWidget {
  final TrackingScrollController scrollController;

  HomeScreenTweetsnDesktop({Key key, @required this.scrollController})
      : super(key: key);

  @override
  _HomeScreenTweetsnDesktopState createState() =>
      _HomeScreenTweetsnDesktopState();
}

class _HomeScreenTweetsnDesktopState extends State<HomeScreenTweetsnDesktop> {
  bool loading;
  bool hasFollowedSomeOne;
  bool userFollowedHasTwitter;

  @override
  void initState() {
    super.initState();
    loading = true;
    hasFollowedSomeOne = false;
    userFollowedHasTwitter = false;

    _hasFollowedSomeOne();
    loadTweetJSON();
  }

  Future<dynamic> loadTweetJSON() async {
    String token = "Bearer " + box.read("token");
    String username = box.read("currentUserId");

    var Url =
        "http://localhost:8080/getTweetFromUser?userTwetterId=" + username;
    var response = await http.get(
      Url,
      headers: <String, String>{
        "Content-Type": "application/json",
        /*"Authorization": token,*/
      },
    );
    print(response.body.toString());

    if (response.statusCode == 200) {
      String responseString = response.body;
      var parsedJson = JsonDecoder().convert(responseString);

      int dataSize = JsonDecoder().convert(response.body).length - 1;
      box.write("dataSize", dataSize.toInt());

      for (int i = 0; i < dataSize; i++) {
        var data = parsedJson["$i"];
        box.write("tweet$i", data);
        print("tweet$i");
      }

      setState(() {
        loading = false;
        userFollowedHasTwitter = true;
        if (parsedJson[0] == {}) userFollowedHasTwitter = false;
      });
    } else if (response.statusCode != 200) {
      setState(() {
        userFollowedHasTwitter = false;
      });
    }
  }

  _hasFollowedSomeOne() async {
    var numFollowing =
        await DatabaseService().numFollowedUser(box.read("currentUserId"));
    print(numFollowing);
    if (numFollowing != 0) {
      setState(() {
        hasFollowedSomeOne = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            color: Colors.grey[100],
          ),
        ),
        //const Spacer(),
        Flexible(
          flex: 16,
          child: CustomScrollView(

            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (hasFollowedSomeOne && userFollowedHasTwitter) {
                      return !loading
                          ? EmbeddedTweetView.fromTweet(
                              Tweet.fromJson(box.read("tweet$index")))
                          : LinearProgressIndicator();
                    } else
                      return !loading
                          ? Center(
                              child: Text("No tweet found"),
                            )
                          : LinearProgressIndicator();
                  },
                  childCount: hasFollowedSomeOne && userFollowedHasTwitter
                      ? box.read("dataSize")
                      : 1,
                ),
              ),
            ],
          ),
        ),
        // const Spacer(),
        Flexible(
          flex: 1,
          child: Container(
            color: Colors.grey[100],
          ),
        ),
      ],
    );
  }
}
