import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:web/models/UserModel.dart';
import 'package:web/models/user_data.dart';
import 'package:web/screens/login/signupForm.dart';
import 'package:http/http.dart' as http;


import '../screens.dart';
final box = GetStorage();


class LoginForm extends StatefulWidget {
  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  Future<UserModel> loginUser(
      String username, String password, BuildContext context) async {
    var Url = "http://localhost:8080/authenticate";
    var response = await http.post(Url,
        headers: <String, String>{
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, String>{
          "username": username,
          "password": password,
        }));

    String responseString = response.body;

    if(response.statusCode!= 200){
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return MyAlertDialog(
              title: "Login Failed",
              content: "username or password incorrect");
        },
      );

    }
    if (response.statusCode == 200) {
      //
      var parsedJson = JsonDecoder().convert(responseString);
      String token = parsedJson['jwt'];
      String userID = parsedJson['id'];
      box.write("currentUserId", userID);
      String username = parsedJson['username'];
      box.write("token", token);
      box.write("username", username);

      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return MyAlertDialog(title: 'Backend Response ${box.read('token')}', content: response.body);
        },
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavScreen()),
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Welcome $username'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      ));
    }
  }
  UserModel userModel;

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

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
            controller: usernameController,
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
            controller: passwordController,
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
            onPressed: () async {
              String username = usernameController.text;
              String password = passwordController.text;
              UserModel user = await loginUser(username, password, context);

              setState(() {
                userModel = user;
              });

              print("Login pressed");
            },
          ),
        ],
      ),
    );
  }
}
