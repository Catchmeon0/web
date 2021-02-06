import 'dart:convert';
import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_ui/embedded_tweet_view.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:web/models/UserModel.dart';
import 'package:web/models/channel_model.dart';
import 'package:web/models/user_data.dart';
import 'package:web/screens/login/loginForm.dart';
import 'package:web/screens/login/logscreen.dart';
import 'package:web/services/api_service.dart';
import 'package:web/services/auth_service.dart';
import 'package:web/services/database_service.dart';
import 'package:web/utilities/constants.dart';
import 'package:web/widgets/post/post_container_youtube.dart';
import 'package:http/http.dart' as http;
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String currentUserId;
  final String userId;

  ProfileScreen({this.currentUserId, this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isFollowing = false;
  int _followerCount = 0;
  int _followingCount = 0;
  UserModel _profileUser;
  Channel _channel;
  bool _isLoading;
  bool _isloadingTweet;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _isloadingTweet = false;
    _setupIsFollowing();
    _setupFollowers();
    _setupFollowing();
    _setupProfileUser();
    _initChannel();
    loadOwnTweetJSON();
  }

  Future<dynamic> loadOwnTweetJSON() async {
    _isloadingTweet = false;
    String token = "Bearer " + box.read("token");
    String userScreenName =
        await DatabaseService().getUserTweetScreenNameFromUserID(widget.userId);

    var Url = "http://localhost:8080/getOwnTweetFromUser?UserScreenName=" +
        userScreenName;
    var response = await http.get(
      Url,
      headers: <String, String>{
        "Content-Type": "application/json",
        /*"Authorization": token,*/
      },
    );
   // print(response.body.toString());

    if (response.statusCode == 200) {
      String responseString = response.body;
      var parsedJson = JsonDecoder().convert(responseString);

       var data = JsonDecoder().convert(response.body);
      box.write("OwnTweetStatus", data);

     // print(box.read("OwnTweetStatus"));

      setState(() {
        _isloadingTweet = false;
      });
    }
  }

  _initChannel() async {
    _isLoading = true;
    dynamic _channelId = await APIService.instance
        .getlistchannelIDfromUserFollowedUsers(await DatabaseService()
            .getUserChannelNameFromUserID(widget.userId));
    if (_channelId.isNotEmpty) {
      Channel channel =
          await APIService.instance.fetchChannel(channelId: _channelId);
      setState(() {
        if (channel != null) {
          _channel = channel;
          _isLoading = false;
        }
      });
    }
  }

  _setupIsFollowing() async {
    bool isFollowingUser = await DatabaseService.isFollowingUser(
      currentUserId: widget.currentUserId,
      userId: widget.userId,
    );
    setState(() {
      _isFollowing = isFollowingUser;
    });
  }

  _setupFollowers() async {
    int userFollowerCount = await DatabaseService.numFollowers(widget.userId);
    setState(() {
      _followerCount = userFollowerCount;
    });
  }

  _setupFollowing() async {
    int userFollowingCount = await DatabaseService.numFollowing(widget.userId);
    setState(() {
      _followingCount = userFollowingCount;
    });
  }

  _setupProfileUser() async {
    UserModel profileUser = await DatabaseService.getUserWithId(widget.userId);
    setState(() {
      _profileUser = profileUser;
    });
  }

  _followOrUnfollow() {
    if (_isFollowing) {
      _unfollowUser();
    } else {
      _followUser();
    }
  }

  _unfollowUser() {
    DatabaseService.unfollowUser(
      currentUserId: widget.currentUserId,
      userId: widget.userId,
    );
    setState(() {
      _isFollowing = false;
      _followerCount--;
    });
  }

  _followUser() {
    DatabaseService.followUser(
      currentUserId: widget.currentUserId,
      userId: widget.userId,
    );
    setState(() {
      _isFollowing = true;
      _followerCount++;
    });
  }

  _displayButton(UserModel user) {
    return user.id == box.read("currentUserId")
        ? Container(
            width: 200.0,
            child: FlatButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfileScreen(
                    user: user,
                    updateUser: (UserModel updateUser) {
                      // Trigger state rebuild after editing profile
                      UserModel updatedUser = UserModel(
                        id: updateUser.id,
                        name: updateUser.name,
                        email: user.email,
                        profileImageUrl: updateUser.profileImageUrl,
                      );
                      setState(() => _profileUser = updatedUser);
                    },
                  ),
                ),
              ),
              color: Colors.blue,
              textColor: Colors.white,
              child: Text(
                'Edit Profile',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          )
        : Container(
            width: 200.0,
            child: FlatButton(
              onPressed: _followOrUnfollow,
              color: _isFollowing ? Colors.grey[200] : Colors.blue,
              textColor: _isFollowing ? Colors.black : Colors.white,
              child: Text(
                _isFollowing ? 'Unfollow' : 'Follow',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
  }

  _buildProfileInfo(UserModel user) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
          child: Row(

            children: <Widget>[
              Container(
                margin:
                EdgeInsets.only(left: 40.0, top: 8.0, bottom: 8.0, right: 12.0),

                child: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: user.profileImageUrl.isEmpty
                      ? AssetImage('assets/images/user_placeholder.jpg')
                      : CachedNetworkImageProvider(user.profileImageUrl),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              _followerCount.toString(),
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'followers',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              _followingCount.toString(),
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'following',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ],
                    ),
                    _displayButton(user),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin : EdgeInsets.only(left: 40.0, top: 8.0, bottom: 8.0, right: 12.0),
                child: Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Divider(),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(

                ),
                !_isloadingTweet && !_isLoading
                    ? EmbeddedTweetView.fromTweet(
                  Tweet.fromJson(box.read("OwnTweetStatus")),
                )
                    : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor, // Red
                    ),
                  ),
                ),

                !_isLoading && !_isloadingTweet
                    ? PostContainerYoutube(channel: _channel)
                    : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor, // Red
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Catchmeon',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Billabong',
            fontSize: 35.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AuthThreePage()),
            ),
            color: Colors.black,
          ),
        ],
      ),
      body: FutureBuilder(
        future: usersRef.doc(widget.userId).get(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            // Uncompleted State
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              // Completed with error
              if (snapshot.hasError)
                return Container(child: Text(snapshot.error.toString()));
              // Completed with data
              if (snapshot.hasData) {
                UserModel user = UserModel.fromDoc(snapshot.data);
                return ListView(
                  children: <Widget>[
                    _buildProfileInfo(user),
                    Divider(),
                  ],
                );
              } else
                return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
/*
  youtubeposteContainer() {
    Channel userChannel;
    userChannel = _channel;
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.red, width: 4, style: BorderStyle.solid)),
          child:  !_isLoading
                ? PostContainerYoutube(channel: userChannel)
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor, // Red
                    ),

          ),
        ),
      ],
    );
  }

  twitterPostContainer() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.blue, width: 4, style: BorderStyle.solid)),
          child: SizedBox(
            width: 350,
            height: 410,
            child: !_isloadingTweet
                ? EmbeddedTweetView.fromTweet(
                    Tweet.fromJson(box.read("OwnTweetStatus")),
                  )
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor, // Red
                    ),
                  ),
          ),
        ),
      ],
    );
  }*/
}
