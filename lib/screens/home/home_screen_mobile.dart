import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:web/config/palette.dart';
import 'package:web/data/data.dart';
import 'package:web/models/UserModel.dart';
import 'package:web/models/models.dart';
import 'package:web/screens/login/logscreen.dart';
import 'package:web/screens/profil/profile_screen.dart';
import 'package:web/screens/search/search_screen.dart';
import 'package:web/widgets/custom_app_bar_mobile.dart';
import 'package:web/widgets/widgets.dart';

class HomeScreenMobile extends StatefulWidget {
  final TrackingScrollController scrollController;
  final UserModel currentUser;

  const HomeScreenMobile(
      {Key key, @required this.scrollController, @required this.currentUser})
      : super(key: key);

  @override
  _HomeScreenMobileState createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  @override
  void initState() {
    super.initState();
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
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                    child:
                        Image.asset("assets/images/CMO_CatchMeOn_black.png")),
                SizedBox(
                  height: 50,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                    child: Expanded(
                        child: Text(
                      "CatchMeOn let you see the last content that your favourite creator put all over his social media in one place, no more wasting time switching between all the apps + you can't get lost in algorithm anymore!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 20),
                            child: Image.asset("assets/gifs/cmo.gif"))),
                  ],
                ),
              ],
            );
          },
          childCount: 1,
        )),
      ],
      semanticChildCount: 1,
    );
  }
}
