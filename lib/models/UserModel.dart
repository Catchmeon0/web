import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelJson(String str) => UserModel.fromJson(jsonDecode(str));

String userModelToJson(UserModel data) => jsonEncode(data);

class UserModel {
  String id;
  String name;
  String username;
  String password;
  String profileImageUrl;
  String email;
  String userTwitter;
  String userYoutube;

  UserModel(
      {this.id,
      this.name,
      this.username,
      this.password,
      this.profileImageUrl,
      this.email,
      this.userTwitter,
      this.userYoutube});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      password: json['password'],
      profileImageUrl: json['profileImageUrl'],
      email: json['email'],
      userTwitter: json['userTwitter'],
      userYoutube: json['userYoutube']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "password": password,
        "profileImageUrl": profileImageUrl,
        "email": email,
        "userTwitter": userTwitter,
        "userYoutube": userYoutube,
      };

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    return UserModel(
        id: doc.id,
        name: doc.data()['name'],
        username: doc.data()['username'],
        password: doc.data()['password'],
        profileImageUrl: doc.data()['profileImageUrl'],
        email: doc.data()['email'],
        userTwitter: doc.data()['userTwitter'],
        userYoutube: doc.data()['userYoutube']);
  }
}
