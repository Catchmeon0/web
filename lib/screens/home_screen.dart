import 'dart:html';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:web/config/palette.dart';
import 'package:web/data/data.dart';
import 'package:web/models/post_model.dart';
import 'package:web/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile:
              _HomeScreenMobile(scrollController: _trackingScrollController),
          desktop:
              _HomeScreenDesktop(scrollController: _trackingScrollController),
        ),
      ),
    );
  }
}

class _HomeScreenMobile extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _HomeScreenMobile({Key key, @required this.scrollController})
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
              icon: MdiIcons.facebook,
              iconSize: 30.0,
              onPressed: () => print('facebook'),
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
          ],
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            final Post post = posts[index];
            return PostContainer(post: post);
          },
          childCount: posts.length,
        )),
      ],
    );
  }
}

class _HomeScreenDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _HomeScreenDesktop({Key key, @required this.scrollController})
      : super(key: key);

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
            controller: scrollController,
            slivers: [
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final Post post = posts[index];
                  return PostContainer(post: post);
                },
                childCount: posts.length,
              )),
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
