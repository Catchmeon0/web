import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:web/config/palette.dart';
import 'package:web/data/data.dart';
import 'package:web/models/models.dart';
import 'package:web/screens/login/loginForm.dart';
import 'package:web/screens/login/logscreen.dart';
import 'package:web/services/api_service.dart';
import 'package:web/services/database_service.dart';
import 'package:web/utilities/keys.dart';
import 'package:web/widgets/widgets.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class HomeScreenYoutubeMobile extends StatefulWidget {
  final TrackingScrollController scrollController;

   HomeScreenYoutubeMobile({Key key, @required this.scrollController})
      : super(key: key);

  @override
  _HomeScreenYoutubeMobileState createState() => _HomeScreenYoutubeMobileState();
}

class _HomeScreenYoutubeMobileState extends State<HomeScreenYoutubeMobile> {
  final List<String> channelsID = ["UC2t5bjwHdUX4vM2g8TRDq5g","UCiRDO4sVx9dsyMm9F7eWMvw", "UCb3c6rB0Ru1i9EUcc-a5ZJw" ];

  String userYoutubeChannelName="wa3errr";
  String channel_id;
  bool _isLoading ;


  List<dynamic> _list;
  @override
  void initState() {
    super.initState();
    _isLoading = false;

    _getListuserChannelYoutube();
  }


  _getListuserChannelYoutube() async{
    print("_getlistuserchannel");
   List<String> list =  await DatabaseService().listofYoutubefromFollowedUsers(box.read("currentUserId")) ;
   print(list);
   print(box.read("currentUserId"));
   setState(() {
     if(list.isNotEmpty){
       _list= list;
       box.write("_list",list);
       box.write("_listSize", list.length);
       print("listsize");
       print(box.read("_listSize"));

        for(int i = 0 ; i < box.read("_listSize"); i++ ){
          String channelID = box.read("_list")[i];
          print(box.read("_list")[i]);
          _initChannel(i, channelID);
     }

     }

   });
  }

  _initChannel(int index, String userYoutubeChannelName) async {
    print("_initChannel");

  String _channelId = await APIService.instance
        .getlistchannelIDfromUserFollowedUsers(userYoutubeChannelName);
  setState(() {
      if(_channelId.isNotEmpty){
        channel_id= _channelId;
        box.write("channel_id$index",_channelId);
        print(box.read("channel_id$index"));
         _isLoading = false;
      }else
       _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: widget.scrollController,
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
          leading: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => print("Avatar"),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(currentUser.imageUrl),
              ),
            ),
          ),

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
              onPressed: () =>  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthThreePage()),
              ),
            ),
          ],
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index)
              {

                return !_isLoading ? HomeScreenYTB( channelID: box.read("channel_id$index")) : LinearProgressIndicator();
              },
              childCount: box.read("_listSize"),
            )
        ),
      ],
    );
  }
}
