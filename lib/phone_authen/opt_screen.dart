
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OPTScreen extends StatefulWidget {
  bool code;
  OPTScreen({Key key, @required this.code}) : super(key: key);
  OPTScreenState createState() => OPTScreenState();
}
class OPTScreenState extends State<OPTScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OTP Confirm'
        ),

      ),
      body: Center(
        child: Column(
          children: <Widget>[

            SizedBox(height: 150,
              width: 150,
              child: Image(image: AssetImage('assets/images/mobile_verfi.png')),),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6)
                  ],
                  decoration: InputDecoration(hintText: 'Enter OTP'),
                  onChanged: (val) {
                    setState(() {
                    //  this.smsCode = val;
                    });
                  },
                )) ,
             Padding(
               padding: EdgeInsets.all(16),
               child: RaisedButton(
                   child: Center(child: Text('Login')),
                   onPressed: () {
                     //  codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                   }),
             )
          ],
        ),
      ),
    );
  }
}