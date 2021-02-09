import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:web/models/UserModel.dart';
import 'package:web/models/activity_model.dart';
import 'package:web/screens/login/loginForm.dart';
import 'package:web/screens/login/logscreen.dart';
import 'package:web/screens/profil/profile_screen.dart';
import 'package:web/screens/search/search_screen.dart';
import 'package:web/services/database_service.dart';
import 'package:web/widgets/widgets.dart';

class ActivityScreenMobile extends StatefulWidget {
  final String currentUserId;
  final UserModel currentUser;
  ActivityScreenMobile({@required this.currentUserId,@required this.currentUser});

  @override
  _ActivityScreenMobileState createState() => _ActivityScreenMobileState();
}

class _ActivityScreenMobileState extends State<ActivityScreenMobile> {
  List<Activity> _activities = [];

  @override
  void initState() {
    super.initState();
    _setupActivities();
  }

  _setupActivities() async {
    List<Activity> activities =
    await DatabaseService.getActivities(widget.currentUserId);
    if (mounted) {
      setState(() {
        _activities = activities;
      });
    }
  }

  _buildActivity(Activity activity) {
    return FutureBuilder(
      future: DatabaseService.getUserWithId(activity.fromUserId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return SizedBox.shrink();
        }
        UserModel user = snapshot.data;
        return ListTile(
          leading: CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.grey,
            backgroundImage: user.profileImageUrl.isEmpty
                ? AssetImage('assets/images/user_placeholder.jpg')
                : CachedNetworkImageProvider(user.profileImageUrl),
          ),
          title: activity.fromUserId != null
              ? Text('${user.name} started catching you')
              : () {},
          subtitle: Text(
            DateFormat.yMd().add_jm().format(activity.timestamp.toDate()),
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProfileScreen(
                currentUserId: box.read("currentUserId"),
                userId: user.id,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: SizedBox(
            height: 80,
            width: 100,
            child: new Image.asset("assets/images/CMO_black.png")),
        centerTitle: false,

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
              onPressed: () {box.remove("token"); Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthThreePage()),
              );},
            ),
        ],
      ),
      body: _activities.isEmpty
          ? Center(
        child: Text('There is no activity at moment'),
      )
          : RefreshIndicator(
        onRefresh: () => _setupActivities(),
        child: ListView.builder(
          itemCount: _activities.length,
          itemBuilder: (BuildContext context, int index) {
            Activity activity = _activities[index];
            return _buildActivity(activity);
          },
        ),
      ),
    );
  }
}
