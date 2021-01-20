import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web/models/UserModel.dart';
import 'package:web/models/user_data.dart';
import 'package:web/services/database_service.dart';

import 'edit_profile_screen.dart';

class ProfilScreen extends StatefulWidget {

  String currentUserId;
  String userId;

  // ProfileScreen({this.currentUserId, this.userId});

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {

  bool _isFollowing = false;
  int _followerCount = 0;
  int _followingCount = 0;
  UserModel _profileUser;

  @override
  void initState() {
    super.initState();
    _setupIsFollowing();
    _setupFollowers();
    _setupFollowing();
    _setupProfileUser();
  }

  _setupIsFollowing() async {
    bool isFollowingUser = await DatabaseService.isFollowingUser(
      currentUserId: widget.currentUserId,
      userId: widget.userId,
    );
    setState(() {
      _isFollowing = isFollowingUser;
    });
  }

  _setupFollowers() async {
    int userFollowerCount = await DatabaseService.numFollowers(widget.userId);
    setState(() {
      _followerCount = userFollowerCount;
    });
  }

  _setupFollowing() async {
    int userFollowingCount = await DatabaseService.numFollowing(widget.userId);
    setState(() {
      _followingCount = userFollowingCount;
    });
  }

  _setupProfileUser() async {
    UserModel profileUser = await DatabaseService.getUserWithId(widget.userId);
    setState(() {
      _profileUser = profileUser;
    });
  }

  _followOrUnfollow() {
    if (_isFollowing) {
      _unfollowUser();
    } else {
      _followUser();
    }
  }

  _unfollowUser() {
    DatabaseService.unfollowUser(
      currentUserId: widget.currentUserId,
      userId: widget.userId,
    );
    setState(() {
      _isFollowing = false;
      _followerCount--;
    });
  }

  _followUser() {
    DatabaseService.followUser(
      currentUserId: widget.currentUserId,
      userId: widget.userId,
    );
    setState(() {
      _isFollowing = true;
      _followerCount++;
    });
  }

  _displayButton(UserModel user) {
    return user.id == Provider.of<UserData>(context).currentUserId
        ? Container(
      width: 200.0,
      child: FlatButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EditProfileScreen(
              user: user,
              updateUser: (UserModel updateUser) {
                // Trigger state rebuild after editing profile
                UserModel updatedUser = UserModel(
                  id: updateUser.id,
                  name: updateUser.name,
                  email: user.email,
                  profileImageUrl: updateUser.profileImageUrl,
                  bio: updateUser.bio,
                );
                setState(() => _profileUser = updatedUser);
              },
            ),
          ),
        ),
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(
          'Edit Profile',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    )
        : Container(
      width: 200.0,
      child: FlatButton(
        onPressed: _followOrUnfollow,
        color: _isFollowing ? Colors.grey[200] : Colors.blue,
        textColor: _isFollowing ? Colors.black : Colors.white,
        child: Text(
          _isFollowing ? 'Unfollow' : 'Follow',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
