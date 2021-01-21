import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web/screens/login/signupForm.dart';

UserModel userModelJson(String str) => UserModel.fromJson(jsonDecode(str));

String userModelToJson(UserModel data) => jsonEncode(data);

class UserModel {
  String id;
  String name;
  String username;
  String password;
  String profileImageUrl;
  String email;
  HashMap<String, String> userIds;

  UserModel(
      {this.id,
      this.name,
      this.username,
      this.password,
        this.profileImageUrl,
        this.email,
      this.userIds});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      password: json['password'],
      profileImageUrl: json['profileImageUrl'],
      email: json['email'],
      userIds: json['userIds']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "password": password,
        "profileImageUrl": profileImageUrl,
        "email": email,
        "userIds": userIds,
  };

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      name: doc['name'],
      username: doc['username'],
      password: doc['password'],
      profileImageUrl: doc['profileImageUrl'],
      email: doc['email'] ?? '',
    );
  }
}
