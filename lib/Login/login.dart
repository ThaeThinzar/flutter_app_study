import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/Home/FirstPageTest.dart';
import 'package:flutterapp/color.dart';
import 'package:local_auth/local_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool authenticated = false;
  @override
  Widget build(BuildContext context) {
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

    _checkBiometrics();
    if(_canCheckBiometrics){
      _getAvailableBiometrics();
      if(_availableBiometrics != null){
        _authenticate();
        if(authenticated){
          Navigator.push(context, MaterialPageRoute(
              builder:  (context)=>
                  FirstPage()));
        }
      }
    }
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Text('Welcome'),
                SizedBox(height: 8,),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/images/welcome.png',color: kShrineBlack,),

                ),
                SizedBox(height: 16.0),

              ],
            ),
            SizedBox(height: 120.0),
            // TODO: Wrap Username with AccentColorOverride (103)
            // TODO: Remove filled: true values (103)
            AccentColorOverride(
              color: Brown900,
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(

                  filled: true,
                  labelText: 'Username',
                ),
              ),
            ),
            SizedBox(height: 12.0),
            // TODO: Wrap Password with AccentColorOverride (103)
            AccentColorOverride(
              color: Brown900,
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
            ),
            ButtonBar(
              children: <Widget>[
                // TODO: Add a beveled rectangular border to CANCEL (103)
                FlatButton(
                  child: Text('CANCEL'),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                ),
                // TODO: Add an elevation to NEXT (103)
                // TODO: Add a beveled rectangular border to NEXT (103)
                RaisedButton(
                  child: Text('NEXT'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Text to login '
                ),
              ],
            ),
          ],
        ),
      ),
    );


  }
}
// TODO: Add AccentColorOverride (103)
class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
        accentColor: color,
        brightness: Brightness.dark,
      ),
    );
  }
}