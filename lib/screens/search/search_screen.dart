import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web/models/UserModel.dart';
import 'package:web/screens/login/loginForm.dart';
import 'package:web/screens/profil/profile_screen.dart';
import 'package:web/services/database_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot> _users;
  String _platform;

  @override
  void initState() {
    super.initState();
    _platform = "CatchMeOn";
  }

  _buildUserTile(UserModel user) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20.0,
        backgroundImage: user.profileImageUrl.isEmpty
            ? AssetImage('assets/images/user_placeholder.jpg')
            : CachedNetworkImageProvider(user.profileImageUrl),
      ),
      title: Text(user.name),
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
  }

  _clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    setState(() {
      _users = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Container(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    border: InputBorder.none,
                    hintText: 'Search',
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30.0,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                      ),
                      onPressed: _clearSearch,
                    ),
                    filled: true,
                  ),
                  onSubmitted: (input) {
                    if (input.isNotEmpty) {
                      setState(() {
                        _users = DatabaseService.searchUsers(input, _platform);
                      });
                    }
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: DropdownButton<String>(
                  value: _platform,
                  icon: Icon(Icons.more_vert_rounded),
                  isExpanded: true,
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.grey),
                  underline: Container(
                    height: 2,
                    color: Colors.blueGrey,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      _platform = newValue;
                    });
                  },
                  items: <String>['CatchMeOn', 'Youtube', 'Twitter']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Center(child: Text("$value")),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _users == null
          ? Center(
              child: Text('Search for a user'),
            )
          : FutureBuilder(
              future: _users,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data.documents.length == 0) {
                  return Center(
                    child: Text('No users found! Please try again.'),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    UserModel user =
                        UserModel.fromDoc(snapshot.data.documents[index]);
                    return _buildUserTile(user);
                  },
                );
              },
            ),
    );
  }
}
