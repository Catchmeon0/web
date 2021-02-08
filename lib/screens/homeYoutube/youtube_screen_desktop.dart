import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:web/config/palette.dart';
import 'package:web/data/data.dart';
import 'package:web/models/channel_model.dart';
import 'package:web/models/models.dart';
import 'package:web/screens/login/loginForm.dart';
import 'package:web/screens/login/logscreen.dart';
import 'package:web/services/api_service.dart';
import 'package:web/services/database_service.dart';
import 'package:web/utilities/keys.dart';
import 'package:web/widgets/widgets.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class HomeScreenYoutubeDesktop extends StatefulWidget {
  final TrackingScrollController scrollController;

  HomeScreenYoutubeDesktop({Key key, @required this.scrollController})
      : super(key: key);

  @override
  _HomeScreenYoutubeDesktopState createState() => _HomeScreenYoutubeDesktopState();
}

class _HomeScreenYoutubeDesktopState extends State<HomeScreenYoutubeDesktop> {

  bool _isLoading ;
  bool _dataExiste;



  List<dynamic> _list;
  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _dataExiste = false;
    _getListuserChannelYoutube();
  }


  _getListuserChannelYoutube() async{

    List<String> list =  await DatabaseService().listofYoutubefromFollowedUsers(box.read("currentUserId")) ;
    box.write("_listSize", list.length);
    setState(() {
      if(list.isNotEmpty){
        setState(() {
          _dataExiste = true;
        });
        _list= list;
        box.write("_list",list);
        for(int i = 0 ; i < box.read("_listSize"); i++ ){
          String channelID = box.read("_list")[i];
          print("channelID--------");
          print(channelID);
          _initChannel(i, channelID);
        }

      }else {
        setState(() {
          _dataExiste = false;
        });
        box.write("channel_id0","UCaeEdy4_WOf4zkyHlwmYxbQ");
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
          box.write("channel_id$index",_channelId);
          _isLoading = false;
        }
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
                  delegate:  _dataExiste ?SliverChildBuilderDelegate(
                        (context, index)
                    {

                      return  HomeScreenYTB( channelID:  box.read("channel_id$index")) ;
                    },
                    childCount:  box.read("_listSize"),
                  ) : SliverChildBuilderDelegate((context, index){return Center(child : Text("No video found"));},childCount: 1)
              ) ,
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
 