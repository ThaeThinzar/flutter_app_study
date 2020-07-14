//import 'dart:html';

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
    new AssetImage('assets/images/punakhadzong.jpg'),] ;

  final carusel = Carousel(
    boxFit: BoxFit.cover,
    images:  [
      new AssetImage('assets/images/bagan.jpg'),
      new AssetImage('assets/images/baganover.jpg'),
      new AssetImage('assets/images/punakhadzong.jpg'),],
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(
      microseconds: 2000,),

  );


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
        body: Center(
          child: Container(
              padding: EdgeInsets.all(20.0),
              height: screenHeight/2,
              child: ClipRRect(borderRadius: BorderRadius.circular(20.0), //step 3 add circular border
                child:Stack(
                  children: <Widget>[
                    carusel,
                    Banner(),
                  ],
                ) ,
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

class Banner extends StatefulWidget{
  BannerState createState() => BannerState();
}
class BannerState extends State<Banner> with SingleTickerProviderStateMixin{
  AnimationController  controller ;
  Animation<double> animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 2000,),
      vsync:this,
    );
    animation = Tween(begin: 0.0, end: 0.0).animate(controller)..addListener(() {setState(() {

    });});
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();


  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 20),
      child:Container(
        decoration: BoxDecoration(
          color: Colors.amber.withOpacity(0.5),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),bottomRight:Radius.circular(15.0)),
        ),
        padding: EdgeInsets.all(10),
        child: new Text('Banner of the t',
          style: TextStyle(
            fontSize: 18,
          ),),
      ),
    );
  }
}