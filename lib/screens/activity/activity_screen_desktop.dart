import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web/models/UserModel.dart';
import 'package:web/models/activity_model.dart';
import 'package:web/screens/login/loginForm.dart';
import 'package:web/screens/profil/profile_screen.dart';
import 'package:web/services/database_service.dart';

class ActivityScreenDesktop extends StatefulWidget {
  final String currentUserId;

  ActivityScreenDesktop({this.currentUserId});

  @override
  _ActivityScreenDesktopState createState() => _ActivityScreenDesktopState();
}

class _ActivityScreenDesktopState extends State<ActivityScreenDesktop> {
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
