import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'github_star_counter.dart';
import 'package:flutterapp/webapp/privacy_police.dart';
class StartCounterApp extends StatefulWidget{
  StartCounterAppState createState()=> StartCounterAppState();

}
class StartCounterAppState extends State<StartCounterApp>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      routes:{
        '/':(context)=> HomePage(),
        '/privacypolicy': (context)=> PrivacyPolicy(),
      }
    );
  }

}

class HomePage extends StatefulWidget{
  HomePageState createState()=> HomePageState();
}
class HomePageState extends State<HomePage>{
  String _repositoryName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Text(
                'GitHub Star Counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter a GitHub repository',
                  hintText: 'flutter/flutter',
                ),
                onSubmitted:(text){
                  setState(() {
                    _repositoryName = text;
                  });
                },
                ),
                Padding(
                  padding: const EdgeInsets.only(top:32.0),
                  child: GitHubStarCounter(
                    repositoryName: _repositoryName,
                  )
                ),
                  FlatButton(
                    color: Colors.transparent,
                    textColor: Colors.blue,
                    onPressed: () => Navigator.of(context).pushNamed('/privacypolicy'),
                    child: Text('Privacy Policy'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}