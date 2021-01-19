import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tweet_ui/embedded_tweet_view.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_api/twitter_api.dart';

class HomeScreenTweets extends StatefulWidget {
  @override
  _HomeScreenTweetsState createState() => _HomeScreenTweetsState();
}

class _HomeScreenTweetsState extends State<HomeScreenTweets> {
  Map<String, dynamic> resBody1 = {
    "created_at": "Mon Jan 18 18:23:40 +0000 2021",
    "id": 135123381472,
    "id_str": "1351233814190829572",
    "text":
        "AAAAAAAAAAAH ÇA FAIT TROP LONGTEMPS PLUS QUE 24H https://t.co/QkeyxSSeeE https://t.co/0RGyOpAtgp",
    "truncated": false,
    "entities": {
      "hashtags": [],
      "symbols": [],
      "user_mentions": [],
      "urls": [
        {
          "url": "https://t.co/QkeyxSSeeE",
          "expanded_url":
              "https://twitter.com/karminecorp/status/1351228653863137281",
          "display_url": "twitter.com/karminecorp/st…",
          "indices": [49, 72]
        }
      ],
      "media": [
        {
          "id": 135123379,
          "id_str": "1351233799854632969",
          "indices": [73, 96],
          "media_url":
              "http://pbs.twimg.com/tweet_video_thumb/EsCL-1jWMAkCInd.jpg",
          "media_url_https":
              "https://pbs.twimg.com/tweet_video_thumb/EsCL-1jWMAkCInd.jpg",
          "url": "https://t.co/0RGyOpAtgp",
          "display_url": "pic.twitter.com/0RGyOpAtgp",
          "expanded_url":
              "https://twitter.com/Kammeto/status/1351233814190829572/photo/1",
          "type": "photo",
          "sizes": {
            "thumb": {"w": 150, "h": 150, "resize": "crop"},
            "small": {"w": 498, "h": 256, "resize": "fit"},
            "large": {"w": 498, "h": 256, "resize": "fit"},
            "medium": {"w": 498, "h": 256, "resize": "fit"}
          }
        }
      ]
    },
    "extended_entities": {
      "media": [
        {
          "id": 1351233,
          "id_str": "1351233799854632969",
          "indices": [73, 96],
          "media_url":
              "http://pbs.twimg.com/tweet_video_thumb/EsCL-1jWMAkCInd.jpg",
          "media_url_https":
              "https://pbs.twimg.com/tweet_video_thumb/EsCL-1jWMAkCInd.jpg",
          "url": "https://t.co/0RGyOpAtgp",
          "display_url": "pic.twitter.com/0RGyOpAtgp",
          "expanded_url":
              "https://twitter.com/Kammeto/status/1351233814190829572/photo/1",
          "type": "animated_gif",
          "sizes": {
            "thumb": {"w": 150, "h": 150, "resize": "crop"},
            "small": {"w": 498, "h": 256, "resize": "fit"},
            "large": {"w": 498, "h": 256, "resize": "fit"},
            "medium": {"w": 498, "h": 256, "resize": "fit"}
          },
          "video_info": {
            "aspect_ratio": [249, 128],
            "variants": [
              {
                "bitrate": 0,
                "content_type": "video/mp4",
                "url": "https://video.twimg.com/tweet_video/EsCL-1jWMAkCInd.mp4"
              }
            ]
          }
        }
      ]
    },
    "source":
        "<a href=\"http://twitter.com/download/iphone\" rel=\"nofollow\">Twitter for iPhone</a>",
    "in_reply_to_status_id": null,
    "in_reply_to_status_id_str": null,
    "in_reply_to_user_id": null,
    "in_reply_to_user_id_str": null,
    "in_reply_to_screen_name": null,
    "user": {
      "id": 1043355650,
      "id_str": "1043355650",
      "name": "Kameto",
      "screen_name": "Kammeto",
      "location": "Corbeil-Essonnes, France",
      "description": "J’emmène la misère en balade @KametoTv & @KarmineCorp",
      "url": "https://t.co/NKlA0IXaI8",
      "entities": {
        "url": {
          "urls": [
            {
              "url": "https://t.co/NKlA0IXaI8",
              "expanded_url": "https://www.instagram.com/kametolol/",
              "display_url": "instagram.com/kametolol/",
              "indices": [0, 23]
            }
          ]
        },
        "description": {"urls": []}
      },
      "protected": false,
      "followers_count": 318004,
      "friends_count": 787,
      "listed_count": 177,
      "created_at": "Fri Dec 28 23:09:05 +0000 2012",
      "favourites_count": 21584,
      "utc_offset": null,
      "time_zone": null,
      "geo_enabled": false,
      "verified": true,
      "statuses_count": 8205,
      "lang": null,
      "contributors_enabled": false,
      "is_translator": false,
      "is_translation_enabled": false,
      "profile_background_color": "000000",
      "profile_background_image_url":
          "http://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_image_url_https":
          "https://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_tile": false,
      "profile_image_url":
          "http://pbs.twimg.com/profile_images/1338477378532765696/UNoVH6HL_normal.jpg",
      "profile_image_url_https":
          "https://pbs.twimg.com/profile_images/1338477378532765696/UNoVH6HL_normal.jpg",
      "profile_banner_url":
          "https://pbs.twimg.com/profile_banners/1043355650/1548962540",
      "profile_link_color": "9266CC",
      "profile_sidebar_border_color": "000000",
      "profile_sidebar_fill_color": "000000",
      "profile_text_color": "000000",
      "profile_use_background_image": false,
      "has_extended_profile": true,
      "default_profile": false,
      "default_profile_image": false,
      "following": null,
      "follow_request_sent": null,
      "notifications": null,
      "translator_type": "regular"
    },
    "geo": null,
    "coordinates": null,
    "place": null,
    "contributors": null,
    "is_quote_status": true,
    "quoted_status_id": 135122,
    "quoted_status_id_str": "1351228653863137281",
    "quoted_status": {
      "created_at": "Mon Jan 18 18:03:10 +0000 2021",
      "id": 1351228,
      "id_str": "1351228653863137281",
      "text":
          "🔴 #LFL 2021 - WEEK 1\n\nLes débuts de la Karmine Corp en LFL, c'est demain et c'est la teeeuuuf ! 🕺🏻\n\n- Mardi 19/01 à… https://t.co/rmDQ4N7USX",
      "truncated": true,
      "entities": {
        "hashtags": [
          {
            "text": "LFL",
            "indices": [2, 6]
          }
        ],
        "symbols": [],
        "user_mentions": [],
        "urls": [
          {
            "url": "https://t.co/rmDQ4N7USX",
            "expanded_url":
                "https://twitter.com/i/web/status/1351228653863137281",
            "display_url": "twitter.com/i/web/status/1…",
            "indices": [117, 140]
          }
        ]
      },
      "source":
          "<a href=\"https://mobile.twitter.com\" rel=\"nofollow\">Twitter Web App</a>",
      "in_reply_to_status_id": null,
      "in_reply_to_status_id_str": null,
      "in_reply_to_user_id": null,
      "in_reply_to_user_id_str": null,
      "in_reply_to_screen_name": null,
      "user": {
        "id": 13221,
        "id_str": "1322196660232114177",
        "name": "Karmine Corp",
        "screen_name": "KarmineCorp",
        "location": "",
        "description":
            "Structure e-sport présente sur League of Legends #LFL, Trackmania et TFT. Sponsored by @msifrance & @ChupaChups_esp  ✉️Contact : contact@karminecorp.fr",
        "url": "https://t.co/CJmeEkmEky",
        "entities": {
          "url": {
            "urls": [
              {
                "url": "https://t.co/CJmeEkmEky",
                "expanded_url": "https://www.karminecorp.fr/",
                "display_url": "karminecorp.fr",
                "indices": [0, 23]
              }
            ]
          },
          "description": {"urls": []}
        },
        "protected": false,
        "followers_count": 47485,
        "friends_count": 16,
        "listed_count": 24,
        "created_at": "Fri Oct 30 15:20:34 +0000 2020",
        "favourites_count": 39,
        "utc_offset": null,
        "time_zone": null,
        "geo_enabled": false,
        "verified": false,
        "statuses_count": 74,
        "lang": null,
        "contributors_enabled": false,
        "is_translator": false,
        "is_translation_enabled": false,
        "profile_background_color": "F5F8FA",
        "profile_background_image_url": null,
        "profile_background_image_url_https": null,
        "profile_background_tile": false,
        "profile_image_url":
            "http://pbs.twimg.com/profile_images/1346169568977444865/8EsreYjO_normal.jpg",
        "profile_image_url_https":
            "https://pbs.twimg.com/profile_images/1346169568977444865/8EsreYjO_normal.jpg",
        "profile_banner_url":
            "https://pbs.twimg.com/profile_banners/1322196660232114177/1610820441",
        "profile_link_color": "1DA1F2",
        "profile_sidebar_border_color": "C0DEED",
        "profile_sidebar_fill_color": "DDEEF6",
        "profile_text_color": "333333",
        "profile_use_background_image": true,
        "has_extended_profile": true,
        "default_profile": true,
        "default_profile_image": false,
        "following": null,
        "follow_request_sent": null,
        "notifications": null,
        "translator_type": "none"
      },
      "geo": null,
      "coordinates": null,
      "place": null,
      "contributors": null,
      "is_quote_status": false,
      "retweet_count": 370,
      "favorite_count": 2305,
      "favorited": false,
      "retweeted": false,
      "possibly_sensitive": false,
      "possibly_sensitive_appealable": false,
      "lang": "fr"
    },
    "retweet_count": 62,
    "favorite_count": 1182,
    "favorited": false,
    "retweeted": false,
    "possibly_sensitive": false,
    "possibly_sensitive_appealable": false,
    "lang": "fr"
  };
  Map<String, dynamic> resBody = {
    "created_at": "Mon Nov 12 13:00:38 +0000 2018",
    "id": 1061967001177018368,
    "id_str": "1061967001177018368",
    "text":
        "Set up this demo account the day I joined GNIP... Six years ago today. #MyTwitterAnniversary https://t.co/Zg4ithsMXv",
    "truncated": false,
    "entities": {
      "hashtags": [
        {
          "text": "MyTwitterAnniversary",
          "indices": [71, 92]
        }
      ],
      "symbols": [],
      "user_mentions": [],
      "urls": [],
      "media": [
        {
          "id_str": "106196699  1848804353",
          "indices": [93, 116],
          "media_url": "http://pbs.twimg.com/media/DrzdWkBWkAEqlHb.jpg",
          "media_url_https": "https://pbs.twimg.com/media/DrzdWkBWkAEqlHb.jpg",
          "url": "https://t.co/Zg4ithsMXv",
          "display_url": "pic.twitter.com/Zg4ithsMXv",
          "expanded_url":
              "https://twitter.com/FloodSocial/status/1061967001177018368/photo/1",
          "type": "photo",
          "sizes": {
            "thumb": {"w": 150, "h": 150, "resize": "crop"},
            "small": {"w": 680, "h": 383, "resize": "fit"},
            "large": {"w": 1920, "h": 1080, "resize": "fit"},
            "medium": {"w": 1200, "h": 675, "resize": "fit"}
          }
        }
      ]
    },
    "extended_entities": {
      "media": [
        {
          "id_str": "1061966991848804353",
          "indices": [93, 116],
          "media_url": "http://pbs.twimg.com/media/DrzdWkBWkAEqlHb.jpg",
          "media_url_https": "https://pbs.twimg.com/media/DrzdWkBWkAEqlHb.jpg",
          "url": "https://t.co/Zg4ithsMXv",
          "display_url": "pic.twitter.com/Zg4ithsMXv",
          "expanded_url":
              "https://twitter.com/FloodSocial/status/1061967001177018368/photo/1",
          "type": "photo",
          "sizes": {
            "thumb": {"w": 150, "h": 150, "resize": "crop"},
            "small": {"w": 680, "h": 383, "resize": "fit"},
            "large": {"w": 1920, "h": 1080, "resize": "fit"},
            "medium": {"w": 1200, "h": 675, "resize": "fit"}
          }
        }
      ]
    },
    "source":
        "<a href=\"http://twitter.com/download/android\" rel=\"nofollow\">Twitter for Android</a>",
    "in_reply_to_status_id": null,
    "in_reply_to_status_id_str": null,
    "in_reply_to_user_id": null,
    "in_reply_to_user_id_str": null,
    "in_reply_to_screen_name": null,
    "user": {
      "id": 944480690,
      "id_str": "944480690",
      "name": "API demos",
      "screen_name": "FloodSocial",
      "location": "Boulder, CO",
      "description":
          "Exploring @TwitterDev, one demo or test at a time. \n🌍💧❄️🌧️☀️ \n@FloodSocial notification sign-up bot was the precursor to @SnowBotDev",
      "url": "https://t.co/rzmuONbWMR",
      "entities": {
        "url": {
          "urls": [
            {
              "url": "https://t.co/rzmuONbWMR",
              "expanded_url": "https://github.com/jimmoffitt/FloodSocial",
              "display_url": "github.com/jimmoffitt/Flo…",
              "indices": [0, 23]
            }
          ]
        },
        "description": {"urls": []}
      },
      "protected": false,
      "followers_count": 73,
      "friends_count": 19,
      "listed_count": 5,
      "created_at": "Mon Nov 12 19:59:55 +0000 2012",
      "favourites_count": 36,
      "utc_offset": null,
      "time_zone": null,
      "geo_enabled": true,
      "verified": true,
      "statuses_count": 187,
      "lang": null,
      "contributors_enabled": false,
      "is_translator": false,
      "is_translation_enabled": false,
      "profile_background_color": "000000",
      "profile_background_image_url":
          "http://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_image_url_https":
          "https://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_tile": false,
      "profile_image_url":
          "http://pbs.twimg.com/profile_images/1162409582213226497/wHPWq9eI_normal.jpg",
      "profile_image_url_https":
          "https://pbs.twimg.com/profile_images/1162409582213226497/wHPWq9eI_normal.jpg",
      "profile_banner_url":
          "https://pbs.twimg.com/profile_banners/944480690/1412809012",
      "profile_link_color": "7FDBB6",
      "profile_sidebar_border_color": "000000",
      "profile_sidebar_fill_color": "000000",
      "profile_text_color": "000000",
      "profile_use_background_image": false,
      "has_extended_profile": false,
      "default_profile": false,
      "default_profile_image": false,
      "following": null,
      "follow_request_sent": null,
      "notifications": null,
      "translator_type": "none"
    },
    "geo": null,
    "coordinates": null,
    "place": null,
    "contributors": null,
    "is_quote_status": false,
    "retweet_count": 0,
    "favorite_count": 2,
    "favorited": false,
    "retweeted": false,
    "possibly_sensitive": false,
    "possibly_sensitive_appealable": false,
    "lang": "en"
  };

  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Container(
            color: Colors.grey[100],
          ),
        ),
        //const Spacer(),
        Container(
          width: 1000,
          child: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return EmbeddedTweetView.fromTweet(Tweet.fromJson(resBody1));
              }, childCount: 1)),
            ],
          ),
        ),
        // const Spacer(),
        Flexible(
          flex: 2,
          child: Container(
            color: Colors.grey[100],
          ),
        ),
      ],
    );
  }
}
