import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web/models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:web/models/models.dart';

import '../screens.dart';

Future<UserModel> registerUser(String username, String email, String password, BuildContext context) async {
  var Url = "http://localhost:8080/signup";
  var response = await http.post(Url,
      headers: <String, String>{"Content-Type": "application/json",},
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



class SignupForm extends StatefulWidget {

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {


  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController pwdController = TextEditingController();

  UserModel userModel;

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
            decoration: InputDecoration(
              labelText: "username",
              hintText: "Enter username",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "email",
              hintText: "Enter email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            controller: pwdController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "password",
              hintText: "Enter password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: "confirm password",
              hintText: "Confirm password",
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
            child: Text("Signup"),
            onPressed: () async {
              String username = usernameController.text;
              String email = emailController.text;
              String password = pwdController.text;
              UserModel user = await registerUser(username, email,password, context );
              usernameController.text = '';
              emailController.text = '';
              pwdController.text = '';

              setState(() {
                userModel = user;
              });

              print("Signup pressed");
              const Duration(seconds: 1);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthThreePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}


class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  MyAlertDialog({
    this.title,
    this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title,
        style: Theme.of(context).textTheme.title,
      ),
      actions: this.actions,
      content: Text(
        this.content,
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }
}