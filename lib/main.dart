import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Home/FirebaseHome.dart';
import 'package:flutterapp/Home/Model/product.dart';
import 'package:flutterapp/backdrop.dart';
import 'package:flutterapp/supporter/cut_corner_border.dart';
import 'package:flutterapp/webapp/StartCounterApp.dart';
import 'Home/HomeScreen.dart';
import 'Home/Repository/DataRepository.dart';
import 'color.dart';
import 'file:///D:/FlutterProject/TestForNewPrj/flutter_app/lib/Home/FirstPageTest.dart';
import 'package:flutterapp/NotificationTestPage.dart';
import 'package:logger/logger.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'Login/login.dart';
import 'menu/icon_badge.dart';
void main() {
  tz.initializeTimeZones();
  var locations = tz.timeZoneDatabase.locations;
  print('location lenght: ${locations.length}'); // => 429
  print('location first:${locations.keys.first}'); // => "Africa/Abidjan"
  print('location last:${locations.keys.last}');
  final logger =  Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 5,
        lineLength: 50,
        colors: true,
        printEmojis: true,
        printTime: false,
      )
  );
 // logger.i('locale testing :${locations}');
  logger.v('You don\'t always want to see all of these');
  logger.d('Logs a debug message');
  logger.i('Public Function called');
  logger.w('This might become a problem');
  logger.e('Something has happened');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ThemeData _buildTheme(){
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      accentColor: Brown900,
      primaryColor: pink100,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: kShrinePurple,
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme.light().copyWith(primary: pink100)
      ),
      buttonBarTheme: base.buttonBarTheme.copyWith(
        buttonTextTheme: ButtonTextTheme.accent,
      ),
      textTheme: _buildShrineTextTheme(base.textTheme),
      primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
      primaryIconTheme: base.iconTheme.copyWith(
          color: SurfaceWhite
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: CutCornersBorder(),
      ),
      scaffoldBackgroundColor: pink100,
      cardColor: kShrinePurple,
      textSelectionColor: pink100,
      errorColor: ErrorRed,
    );
  }
  TextTheme _buildShrineTextTheme(TextTheme base) {
    return base.copyWith(
      headline: base.headline.copyWith(
        fontWeight: FontWeight.w500,
      ),
      title: base.title.copyWith(
          fontSize: 18.0
      ),
      caption: base.caption.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
      ),
    ).apply(
      fontFamily: 'Rubik',
      displayColor: Brown900,
      bodyColor: Brown900,
    );
  }
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('ja'),
      title: 'Flutter Demo',
      theme:_buildTheme() ,
        debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'My FireBase page',));
  }
  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  final databaseReference = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          /*  Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),*/
            RaisedButton(
              child: Text('Create Record'),
              onPressed: () {
                createRecord();
              },
            ),
            RaisedButton(
              child: Text('View Record'),
              onPressed: () {
                getData();
              },
            ),
            RaisedButton(
              child: Text('Update Record'),
              onPressed: () {
                updateData();
              },
            ),
            RaisedButton(
              child: Text('Delete Record'),
              onPressed: () {
                deleteData();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void createRecord() async {
    await databaseReference.collection("books")
        .document("1")
        .setData({
      'title': 'Mastering Flutter',
      'description': 'Programming Guide for Dart'
    });

    DocumentReference ref = await databaseReference.collection("books")
        .add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
    print(ref.documentID);
  }

  void getData() {
    databaseReference
        .collection("books")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  void updateData() {
    try {
      databaseReference
          .collection('books')
          .document('1')
          .updateData({'description': 'Head First Flutter'});
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteData() {
    try {
      databaseReference
          .collection('books')
          .document('1')
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

}
