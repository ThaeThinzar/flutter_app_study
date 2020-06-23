import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationTestPage extends StatefulWidget{
  @override
  NotificationTestPageState createState() => NotificationTestPageState();

}
class NotificationTestPageState extends State<NotificationTestPage>{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Test Page'),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        new RaisedButton(
        onPressed: (){},
          child: new Text('Show Notification With Sound'),
        ),
        new SizedBox(
          height: 30.0,
        ),
        new RaisedButton(
          onPressed:(){

          },
          child: new Text('Show Notification Without Sound'),
        ),
        new SizedBox(
          height: 30.0,
        ),
        new RaisedButton(
          onPressed: (){_showNotificationWithSound();},
          child: new Text('Show Notification With Default Sound'),
        )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {

    var initializationSettingsAndroid = new AndroidInitializationSettings('ic_launcher.png');
    var initializationSettingsiOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsiOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }
  Future onSelectNotification(String payload) async{
    showDialog(context: context,
    builder: (_)=> new AlertDialog(
      title: new Text('Title'),
      content: new Text('Contesnt'),
    ),
    );

  }
  Future _showNotificationWithSound() async{
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails('your channel id', "channelName", "channelDescription",
    importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Post',
      'How to Show Notification in Flutter',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );

  }
}