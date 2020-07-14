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

    return Scaffold(
        body: Container(
          child: CarouselSlider(
            options: CarouselOptions(),
            items: imgList.map((item)=>Container(
              child: Center(
                  child: Image(
                  image: item, width: 200,height: 150,fit: BoxFit.cover,),),
            )).toList(),
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