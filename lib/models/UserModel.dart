import 'dart:collection';
import 'dart:convert';

import 'package:web/screens/login/signupForm.dart';

UserModel userModelJson(String str) => UserModel.fromJson(jsonDecode(str));

String userModelToJson(UserModel data) => jsonEncode(data);

class UserModel {
  String id;
  String firstName;
  String lastName;
  String username;
  String password;
  String email;
  HashMap<String, String> userIds;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.password,
      this.email,
      this.userIds});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      userIds: json['userIds']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "password": password,
        "email": email,
        "userIds": userIds,
      };

  String get userName => username;

  String get firstname => firstName;

  String get lastname => lastName;

  String get pwd => password;

  String get pseudoname => username;

  String get mailadress => email;

  String get userids => userids;
}
