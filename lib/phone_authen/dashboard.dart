import 'package:flutter/material.dart';
import 'package:flutterapp/phone_authen/authservice.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: RaisedButton(
              child: Text('Sign out'),
              onPressed: () {
                AuthService().signOut();
              },
            )
        )
    );
  }
}