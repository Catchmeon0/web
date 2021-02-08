import 'package:flutter/material.dart';
import 'package:web/models/UserModel.dart';
import 'package:web/models/models.dart';
import 'package:web/screens/profil/profile_screen.dart';
import 'package:web/widgets/widgets.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen(
          currentUserId: user.id,
          userId: user.id,
        )),
      ); },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileAvatar(imageUrl: user.profileImageUrl.length != 0 ? user.profileImageUrl: ("assets/images/user_placeholder.jpg") ),
          const SizedBox(width: 6.0),
          Flexible(
            child: Text(
              user.name,
              style: const TextStyle(fontSize: 16.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}