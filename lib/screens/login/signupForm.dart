import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web/models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:web/models/models.dart';

import '../screens.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
// Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController pwdController = TextEditingController();
  TextEditingController pwdControllerConfirmation = TextEditingController();

  UserModel userModel;

  bool loading;

  @override
  void initState() {
    super.initState();
    loading = true;
  }

  Future<UserModel> registerUser(String username, String email, String password,
      BuildContext context) async {
    var Url = "http://localhost:8080/signup";
    var response = await http.post(Url,
        headers: <String, String>{
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, String>{
          "username": username,
          "email": email,
          "password": password,
        }));

    String responseString = response.body;
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
   /*   if (response.statusCode == 400) {
        String error =  JsonDecoder().convert(response.body)["error"]["message"];
        if( error== "EMAIL_EXISTS") ;
      }*/
    /*  showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return MyAlertDialog(
              title: 'Backend Response', content: responseString);
        },
      );*/
      Navigator.pop(context);


    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
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
              validator: validateUsername,
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                labelText: "email",
                hintText: "Enter email",
                border: OutlineInputBorder(),
              ),
              validator: validateEmail,
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
              validator: validatePassword,
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: pwdControllerConfirmation,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "confirm password",
                hintText: "Confirm password",
                border: OutlineInputBorder(),
              ),
              validator: (value) => validatePasswordConfirma(
                  value, pwdController.text, pwdControllerConfirmation.text),
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
                if (_formKey.currentState.validate()) {
                  String username = usernameController.text;
                  String email = emailController.text;
                  String password = pwdController.text;
                  UserModel user =
                      await registerUser(username, email, password, context);
               /*   usernameController.text = '';
                  emailController.text = '';
                  pwdController.text = '';
                  pwdControllerConfirmation.text = '';*/

                  setState(() {
                    userModel = user;
                  });

                  print("Signup pressed");
                }
                if (!loading) {
                  String username = usernameController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthThreePage()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('$username account has been created'),
                    duration: const Duration(seconds: 3),
                    action: SnackBarAction(
                      label: 'Close',
                      onPressed: () {},
                    ),
                  ));
                }
              },
            ),
          ],
        ),
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

String validateUsername(String value) {
  if (value.length < 4)
    return 'Name must be more than 3 charater';
  else
    return null;
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty) {
    return 'Please Enter Email';
  }
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}

String validatePasswordConfirma(String value, String pwd, String pwdConfirm) {
  if (value.isEmpty)
    return 'Please confirm password';
  else if (pwd != pwdConfirm) {
    return 'Password do not match';
  } else
    return null;
}

String validatePassword(String value) {
  if (value.isEmpty)
    return 'Please Enter password';
  else if (value.length < 6)
    return 'password must contain at least 6 characters';
  return null;
}
