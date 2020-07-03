import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

/*
class HomeScreen extends StatelessWidget{
  final LocalAuthentication localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: GestureDetector(
        onTap:() async{
          bool weCanCheckBio = await localAuth.canCheckBiometrics;
          print("Touch Biometric started");

          if(weCanCheckBio){
          bool authenthicated = await localAuth.authenticateWithBiometrics(localizedReason: "Authetnt to see you app");
          print(authenthicated);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.fingerprint,
              size: 124.0,
            ),
            Text(
              "Touch to login",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue, fontSize: 48
              ),
            )
          ],
        ),
      ),
    );
  }

}*/


class HomeApp extends StatefulWidget{
  @override
  HomeAppState createState() => HomeAppState();
}
class HomeAppState extends State<HomeApp> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }
  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: false);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _authorized = authenticated ? 'Authorized' : 'Not Authorized';
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('Can check biometrics: $_canCheckBiometrics\n'),
                    RaisedButton(
                      child: const Text('Check biometrics'),
                      onPressed: _checkBiometrics,
                    ),
                    Text('Available biometrics: $_availableBiometrics\n'),
                    RaisedButton(
                      child: const Text('Get available biometrics'),
                      onPressed: _getAvailableBiometrics,
                    ),
                    Text('Current State: $_authorized\n'),
                    RaisedButton(
                      child: const Text('Authenticate'),
                      onPressed: _authenticate,
                    )
                  ])),
        )
    );

  }

}