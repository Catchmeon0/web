import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:web/config/palette.dart';
import 'package:web/data/data.dart';
import 'package:web/models/models.dart';
import 'package:web/screens/login/logscreen.dart';
import 'package:web/widgets/widgets.dart';

import 'home_screen.dart';

class HomeScreenYoutubeMobile extends StatelessWidget {
  final TrackingScrollController scrollController;

  const HomeScreenYoutubeMobile({Key key, @required this.scrollController})
      : super(key: key);

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
                  (context, index) {
                final Post post = posts[index];
                return HomeScreenYTB();
              },
              childCount: 1,
            )
        ),
      ],
    );
  }
}
