// ignore_for_file: prefer_const_constructors
import 'package:to_do_list/userservice.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class loginscreen extends StatelessWidget {
  loginscreen({
    Key? key, required this.title }) : super(key: key);
    final String title;
    final TextEditingController _email = TextEditingController();
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
              controller: _email,
              decoration: InputDecoration(
                labelText: 'Input Email:'
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
              onPressed: () async {
                try {
                  await loginuser(_email.text, _password.text);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'To-Do')));
                } catch (err) {
                  Fluttertoast.showToast(msg: 'Error: $err');
                }
              },
              child: Text('Login'))
          ]),
        )
      ),
    );
  }
}