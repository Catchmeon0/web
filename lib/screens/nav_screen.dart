import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:web/data/data.dart';
import 'package:web/screens/activity/activity_screen.dart';
import 'package:web/screens/profil/profile_screen.dart';
import 'package:web/screens/screens.dart';
import 'package:web/widgets/custom_app_bar.dart';
import 'package:web/widgets/widgets.dart';

import 'homeTwetter/tweet_screen.dart';
import 'homeYoutube/youtube_screen.dart';
import 'login/loginForm.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final String currentUserId = box.read("currentUserId");
  final List<Widget> _screens = [
    HomeScreen(),
    ProfileScreen(
      currentUserId: box.read("currentUserId"),
      userId: box.read("currentUserId"),
    ),
    ActivityScreen(currentUserId: box.read("currentUserId")),
    HomeScreenTweets(),
    HomeScreenYoutube(),
  ];
  final List<IconData> _icons = const [
    Icons.home,
    MdiIcons.accountCircleOutline,
    MdiIcons.heart,
    MdiIcons.twitter,
    MdiIcons.youtube,
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
        length: _icons.length,
        child: Scaffold(
          appBar: Responsive.isDesktop(context)
              ? PreferredSize(
                  preferredSize: Size(screenSize.width, 100.0),
                  child: CustomAppBar(
                    currentUser: currentUser,
                    icons: _icons,
                    selectedIndex: _selectedIndex,
                    onTap: (index) => setState(() => _selectedIndex = index),
                  ),
                )
              : null,
          body: _screens[_selectedIndex],
          bottomNavigationBar: !Responsive.isDesktop(context)
              ? CustomTabBar(
                  icons: _icons,
                  selectedIndex: _selectedIndex,
                  onTap: (index) => setState(() => _selectedIndex = index),
                )
              : const SizedBox.shrink(),
        ));
  }
}
