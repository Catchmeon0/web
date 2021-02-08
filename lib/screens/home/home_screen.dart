
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:web/config/palette.dart';
import 'package:web/data/data.dart';
import 'package:web/models/UserModel.dart';
import 'package:web/models/post_model.dart';
import 'package:web/screens/login/loginForm.dart';
import 'package:web/services/database_service.dart';
import 'package:web/widgets/widgets.dart';

import 'home_screen_desktop.dart';
import 'home_screen_mobile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  UserModel _user;
  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile:
              HomeScreenMobile(scrollController: _trackingScrollController, currentUser: _user,),
          desktop:
              HomeScreenDesktop(scrollController: _trackingScrollController),
        ),
      ),
    );
  }
}


