import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:web/config/palette.dart';
import 'package:web/data/data.dart';
import 'package:web/models/UserModel.dart';
import 'package:web/models/channel_model.dart';
import 'package:web/models/models.dart';
import 'package:web/screens/login/loginForm.dart';
import 'package:web/screens/login/logscreen.dart';
import 'package:web/screens/profil/profile_screen.dart';
import 'package:web/screens/search/search_screen.dart';
import 'package:web/services/api_service.dart';
import 'package:web/services/database_service.dart';
import 'package:web/utilities/keys.dart';
import 'package:web/widgets/widgets.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class HomeScreenYoutubeMobile extends StatefulWidget {
  final TrackingScrollController scrollController;
  final UserModel currentUser;

  HomeScreenYoutubeMobile(
      {Key key, @required this.scrollController, @required this.currentUser})
      : super(key: key);

  @override
  _HomeScreenYoutubeMobileState createState() =>
      _HomeScreenYoutubeMobileState();
}

class _HomeScreenYoutubeMobileState extends State<HomeScreenYoutubeMobile> {
  bool _isLoading;

  bool _dataExiste;

  List<dynamic> _list;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _dataExiste = false;
    _getListuserChannelYoutube();
  }

  _getListuserChannelYoutube() async {
    List<String> list = await DatabaseService()
        .listofYoutubefromFollowedUsers(box.read("currentUserId"));
    box.write("_listSize", list.length);
    setState(() {
      if (list.isNotEmpty) {
        setState(() {
          _dataExiste = true;
        });
        _list = list;
        box.write("_list", list);
        for (int i = 0; i < box.read("_listSize"); i++) {
          String channelID = box.read("_list")[i];
          print("channelID--------");
          print(channelID);
          _initChannel(i, channelID);
        }
      } else {
        setState(() {
          _dataExiste = false;
        });
        box.write("channel_id0", "UCaeEdy4_WOf4zkyHlwmYxbQ");
      }
    });
  }

  _initChannel(int index, String userYoutubeChannelName) async {
    _isLoading = true;
    dynamic _channelId = await APIService.instance
        .getlistchannelIDfromUserFollowedUsers(userYoutubeChannelName);
    if (_channelId.isNotEmpty) {
      setState(() {
        if (_channelId != null) {
          box.write("channel_id$index", _channelId);
          _isLoading = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: widget.scrollController,
      slivers: [
        SliverAppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: SizedBox(
              height: 80,
              width: 100,
              child: new Image.asset("assets/images/CMO_black.png")),
          centerTitle: false,
          floating: true,
          //avatar Image
          leading: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                            currentUserId: widget.currentUser.id,
                            userId: widget.currentUser.id,
                          )),
                )
              },
              child: ProfileAvatar(
                  imageUrl: ("assets/images/user_placeholder.jpg")),
            ),
          ),

          actions: [
            CircleButton(
              icon: Icons.search,
              iconSize: 30.0,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              ),
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
            delegate: _dataExiste
                ? SliverChildBuilderDelegate(
                    (context, index) {
                      return HomeScreenYTB(
                          channelID: box.read("channel_id$index"));
                    },
                    childCount: box.read("_listSize"),
                  )
                : SliverChildBuilderDelegate((context, index) {
                    return Center(child: Text("No video found"));
                  }, childCount: 1)),
      ],
    );
  }
}
