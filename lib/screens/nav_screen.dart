import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:web/data/data.dart';
import 'package:web/models/UserModel.dart';
import 'package:web/screens/activity/activity_screen.dart';
import 'package:web/screens/profil/profile_main_screen.dart';
import 'package:web/screens/profil/profile_screen.dart';
import 'package:web/screens/screens.dart';
import 'package:web/services/database_service.dart';
import 'package:web/widgets/custom_app_bar.dart';
import 'package:web/widgets/widgets.dart';

import 'activity/activity_main_screen.dart';
import 'homeTwetter/tweet_screen.dart';
import 'homeYoutube/youtube_main_screen.dart';
import 'login/loginForm.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  UserModel _user;
  final String currentUserId = box.read("currentUserId");
  final List<Widget> _screens = [
    HomeScreen(),
    HomeScreenTweets(),
    HomeMainScreenYoutube(),
    ActivityMainScreen(currentUserId: box.read("currentUserId")),

    ProfileMainScreen(
      currentUserId: box.read("currentUserId"),
      userId: box.read("currentUserId"),
    ),

  ];
  final List<IconData> _icons = const [
    Icons.home,
    MdiIcons.twitter,
    MdiIcons.youtube,
  Icons.notifications,
    MdiIcons.account,


  ];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCurrentUserInfo();
  }

  _getCurrentUserInfo()async{
  UserModel user = await DatabaseService().currentUser(box.read("currentUserId"));

  setState(() {
      _user= user;
  });
  }


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
                    currentUser: _user,
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
