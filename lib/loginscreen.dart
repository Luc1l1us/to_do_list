// ignore_for_file: prefer_const_constructors
import 'package:to_do_list/userservice.dart';

import 'main.dart';
import 'package:flutter/material.dart';

class loginscreen extends StatelessWidget {
  loginscreen({
    Key? key, required this.title }) : super(key: key);
    final String title;
    final TextEditingController _username = TextEditingController();
    final TextEditingController _password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(50),
          child: Column(children: <Widget>[
            TextFormField(
              controller: _username,
              decoration: InputDecoration(
                labelText: 'Input Username:'
              ),
            ),
            TextFormField(
              controller: _password,
              decoration: InputDecoration(
                labelText: 'Input Password:'
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                registeruser(_username.text, _password.text, '', '');
              },
              child: Text('Register'))
          ]),
        )
      ),
    );
  }
}