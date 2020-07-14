import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/phone_authen/authservice.dart';
import 'package:flutterapp/phone_authen/opt_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 25.0,top: 60.0, right: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     codeSent?  SizedBox(height: 150,
                       width: 150,
                       child: Image(image: AssetImage('assets/images/mobile_verfi.png')),):
                     Padding(
                       padding:EdgeInsets.only(top: 60, bottom: 25),
                       child: Text('What is your phone number?', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),),
                     ),
                     SizedBox(height: 10,),
                     codeSent? Container():
                     TextFormField(
                       keyboardType: TextInputType.phone,
                       decoration: InputDecoration(hintText: 'Enter phone number'),
                       onChanged: (val) {
                         setState(() {
                           this.phoneNo = val;
                         });
                       },
                     ),
                    ],
                  )
              ),
              /*codeSent ?
              SizedBox(height: 150,
                        width: 150,
                         child: Image(image: AssetImage('assets/images/mobile_verfi.png')),):Container(),*/
              codeSent ? Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Enter OTP'),
                    onChanged: (val) {
                      setState(() {
                        this.smsCode = val;
                      });
                    },
                  )) : Container(),
            /* codeSent? Navigator.push(context, MaterialPageRoute(
               builder: (context)=> OPTScreen(code:codeSent)
             )):Container(),*/
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: RaisedButton(
                      child: Center(child: codeSent ? Text('Login'):Text('Next')),
                      onPressed: () {
                        codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                      }))
            ],
          )),
    );
  }
  Future<void> _showMyDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return   AlertDialog(
          title: Text('Invalid Format'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please enter your phone number with your country code'),
                Text('[Eg.+9598214455]')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],);
      },
    );
  }
  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {

      print('${authException.message}');
      _showMyDialog(authException.message);

    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}