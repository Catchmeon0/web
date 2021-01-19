import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tweet_ui/embedded_tweet_view.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_webview/tweet_webview.dart';
import 'package:web/config/palette.dart';
import 'package:web/data/data.dart';
import 'package:web/models/models.dart';
import 'package:web/widgets/widgets.dart';

class HomeScreenTweetsnMobile extends StatelessWidget {
  var resBody = [];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Scaffold(
          appBar: AppBar(
            title: Text('Tweet WebView Example 2'),
          ),
          body: Scaffold(
              body: EmbeddedTweetView.fromTweet(Tweet.fromJson(resBody[0]))),
        ),
      ],
    );
  }
}
