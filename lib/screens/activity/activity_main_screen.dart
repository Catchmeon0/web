
import 'package:flutter/material.dart';

import 'package:web/models/UserModel.dart';
import 'package:web/screens/login/loginForm.dart';
import 'package:web/services/database_service.dart';
import 'package:web/widgets/widgets.dart';

import 'activity_screen_desktop.dart';
import 'activity_screen_mobile.dart';


class ActivityMainScreen extends StatefulWidget {
  final String currentUserId;

  const ActivityMainScreen({Key key, this.currentUserId}) : super(key: key);


  @override
  _ActivityMainScreenState createState() => _ActivityMainScreenState();
}

class _ActivityMainScreenState extends State<ActivityMainScreen> {
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
          ActivityScreenMobile(currentUser: _user, currentUserId: widget.currentUserId,),

          desktop:
          ActivityScreenDesktop(currentUserId: widget.currentUserId,),
        ),
      ),
    );
  }
}


