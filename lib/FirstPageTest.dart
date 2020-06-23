import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget{
  @override
  FirstPageState createState() => FirstPageState();
}
class FirstPageState extends State<FirstPage>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('First Page'),
     )
   );
  }

}