import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:web/models/UserModel.dart';
import 'package:web/services/database_service.dart';
import 'package:web/services/storage_service.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;
  final Function updateUser;

  EditProfileScreen({this.user, this.updateUser});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  File _profileImage;
  String _name = '';
  String _userTwitter='';
  String _userYoutube='';

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _userTwitter=widget.user.userTwitter;
    _userYoutube=widget.user.userYoutube;
    // _bio = widget.user.bio;
  }

  _handleImageFromGallery() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _profileImage = imageFile;
      });
    }
  }

  _displayProfileImage() {
    // No new profile image
    if (_profileImage == null) {
      // No existing profile image
      if (widget.user.profileImageUrl.isEmpty) {
        // Display placeholder
        return AssetImage('assets/images/user_placeholder.jpg');
      } else {
        // User profile image exists
        return CachedNetworkImageProvider(widget.user.profileImageUrl);
      }
    } else {
      // New profile image
      return FileImage(_profileImage);
    }
  }

  _submit() async {
    if (_formKey.currentState.validate() && !_isLoading) {
      _formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });

      // Update user in database
      String _profileImageUrl = '';

      if (_profileImage == null) {
        _profileImageUrl = widget.user.profileImageUrl;
      } else {
        _profileImageUrl = await StorageService.uploadUserProfileImage(
          widget.user.profileImageUrl,
          _profileImage,
        );
      }

      UserModel user = UserModel(
        id: widget.user.id,
        name: _name,
        userTwitter: _userTwitter,
        userYoutube: _userYoutube,
        profileImageUrl: _profileImageUrl,
      );

      // Database update
      DatabaseService.updateUser(user);

      widget.updateUser(user);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: <Widget>[
            _isLoading
                ? LinearProgressIndicator(
              backgroundColor: Colors.blue[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            )
                : SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: _displayProfileImage(),
                    ),
                    FlatButton(
                      onPressed: _handleImageFromGallery,
                      child: Text(
                        'Change Profile Image',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0),
                      ),
                    ),
                    TextFormField(
                      initialValue: _name,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          size: 30.0,
                        ),
                        labelText: 'Name',
                      ),
                      validator: (input) => input.trim().length < 1
                          ? 'Please enter a valid name'
                          : null,
                      onSaved: (input) => _name = input,
                    ),
                    TextFormField(
                      initialValue: _userTwitter,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        icon: Icon(
                          MdiIcons.twitter,
                          size: 30.0,
                        ),
                        labelText: 'Your Twitter',
                      ),
                      validator: (input) => input.trim().length < 1
                          ? 'Please enter a valid Twitter @'
                          : null,
                      onSaved: (input) => _userTwitter = input,
                    ),
                    TextFormField(
                      initialValue: _userYoutube,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        icon: Icon(
                          MdiIcons.youtube,
                          size: 30.0,
                        ),
                        labelText: 'Your Youtube',
                      ),
                      validator: (input) => input.trim().length < 1
                          ? 'Please enter a valid Youtube channel name '
                          : null,
                      onSaved: (input) => _userYoutube = input,
                    ),
                    Container(
                      margin: EdgeInsets.all(40.0),
                      height: 40.0,
                      width: 250.0,
                      child: FlatButton(
                        onPressed: _submit,
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text(
                          'Save Profile',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
