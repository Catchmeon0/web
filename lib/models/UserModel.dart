import 'dart:convert';

UserModel userModelJson(String str) => UserModel.fromJson(jsonDecode(str));

String userModelToJson(UserModel data) => jsonEncode(data);

class UserModel {
  String id;
  String firstName;
  String lastName;
  String username;
  String password;
  String email;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.password,
      this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      password: json['password'],
      email: json['email']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "password": password,
        "email": email,
      };

  String get userName => username;

  String get firstname => firstName;

  String get lastname => lastName;

  String get pwd => password;

  String get pseudoname => username;

  String get mailadress => email;
}
