import 'package:flutter/material.dart';
import 'package:flutter_truecaller/flutter_truecaller.dart';

import 'HomePage.dart';

class VerifyMobileNumber extends StatefulWidget {
  const VerifyMobileNumber({Key key}) : super(key: key);

  @override
  _VerifyMobileNumberState createState() => _VerifyMobileNumberState();
}

class _VerifyMobileNumberState extends State<VerifyMobileNumber> {
  TextEditingController _mobile = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _otp = TextEditingController();
  FlutterTruecaller truecaller = FlutterTruecaller();

  bool otpRequired = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
    
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            child: TextField(
          controller: _mobile,
          keyboardType: TextInputType.phone,
        )),
        OutlineButton(
            onPressed: () async {
              otpRequired = await truecaller.requestVerification(_mobile.text);
            },
            child: Text("Verify")),
        if (otpRequired)
          Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: _otp,
                keyboardType: TextInputType.phone,
              )),
        Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: _firstName,
            )),
        Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: _lastName,
            )),
        OutlineButton(
            onPressed: () async {
              if (otpRequired) {
                await truecaller.verifyOtp(
                    _firstName.text, _lastName.text, _otp.text);
              } else {
                Future.delayed(Duration(seconds: 3));
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()));
              }
            },
            child: Text("Submit")),
        StreamBuilder<String>(
            stream: FlutterTruecaller.callback,
            builder: (context, snapshot) => Text(snapshot.data ?? "")),
        StreamBuilder<FlutterTruecallerException>(
            stream: FlutterTruecaller.errors,
            builder: (context, snapshot) =>
                Text(snapshot.hasData ? snapshot.data.errorMessage : "")),
        StreamBuilder<TruecallerProfile>(
            stream: FlutterTruecaller.trueProfile,
            builder: (context, snapshot) => Text(snapshot.hasData
                ? snapshot.data.firstName + "" + snapshot.data.lastName
                : "")),
      ],
      )  );
  }
}
