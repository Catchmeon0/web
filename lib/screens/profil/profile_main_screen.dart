import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web/screens/profil/profile_screen_desktop.dart';
import 'package:web/screens/profil/profile_screen_mobile.dart';
import 'package:web/widgets/widgets.dart';


class ProfileMainScreen extends StatefulWidget {
  final String currentUserId;
  final String userId;

  const ProfileMainScreen({Key key, this.currentUserId, this.userId}) : super(key: key);
  @override
  _ProfileMainScreen createState() => _ProfileMainScreen();
}

class _ProfileMainScreen extends State<ProfileMainScreen> {

  final TrackingScrollController _trackingScrollController =
  TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Responsive(
            mobile:
            ProfileScreenMobile(currentUserId: widget.currentUserId,userId: widget.userId,),

            desktop:
            ProfileScreenDesktop(currentUserId: widget.currentUserId,userId: widget.userId,),
          ),
        ),
      );


  }
}

