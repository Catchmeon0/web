import 'dart:convert';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:web/models/UserModel.dart';
import 'package:web/screens/login/signupForm.dart';
import 'package:http/http.dart' as http;

import '../screens.dart';




Future<UserModel> registerUser(String username, String email, String password,
    BuildContext context) async {
  var Url = "http://localhost:8080/signup";
  var response = await http.post(Url,
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "username": username,
        "email": email,
        "password": password,
      }));

  String responseString = response.body;
  if (response.statusCode == 200) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return MyAlertDialog(title: 'Backend Response', content: response.body);
      },
    );
  }
}


class LoginForm extends StatelessWidget {
  void loginPressed() {
    print("Login pressed");
  }

  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextFormField(
            // ignore: missing_return
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter your usename';
              }
            },
            decoration: InputDecoration(
              labelText: 'username',
              hintText: "Enter your username",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            // ignore: missing_return
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter your password';
              }
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'password',
              hintText: "Enter password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text("Login"),
            onPressed: loginPressed,
          ),
        ],
      ),
    );
  }
}
