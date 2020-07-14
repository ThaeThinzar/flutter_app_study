import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/phone_authen/authservice.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<AssetImage> imgList = [
    new AssetImage('assets/images/bagan.jpg'),
    new AssetImage('assets/images/baganover.jpg'),
    new AssetImage('assets/images/bridge.jpg'),] ;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(

        body: Center(
          child: Container(
              padding: EdgeInsets.all(20.0),
              height: screenHeight/2,
              child: Carousel(
                boxFit: BoxFit.cover,
                images: imgList,
                animationCurve: Curves.fastOutSlowIn,
                animationDuration: Duration(
                  microseconds: 2000,),

              )
          ),
        )
      /*Center(
            child: Colum
          *//* RaisedButton(
              child: Text('Sign out'),
              onPressed: () {
              //  AuthService().signOut();
              },
            )*//*
        )*/
    );
  }
}