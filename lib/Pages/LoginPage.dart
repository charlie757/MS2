import 'package:flutter/material.dart';
import 'package:flutter_truecaller/flutter_truecaller.dart';

import 'HomePage.dart';
import 'VerifyMobileNumber.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key key}) : super(key: key);

  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final FlutterTruecaller truecaller = FlutterTruecaller();

  void initState() {
    super.initState();
    getTrueCaller();
  }

  Future getTrueCaller() async {
    await truecaller.initializeSDK(
      consentMode: FlutterTruecallerScope.CONSENT_MODE_POPUP,
      consentTitleOptions: FlutterTruecallerScope.SDK_CONSENT_TITLE_LOG_IN,
      footerType: FlutterTruecallerScope.FOOTER_TYPE_ANOTHER_METHOD,
      sdkOptions: FlutterTruecallerScope.SDK_OPTION_WITH_OTP,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("TrueCaller")),
        body: Column(children: [
          Text("Login and Sign-Up"),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
              onPressed: () async {
                await truecaller.getProfile();
                FlutterTruecaller.manualVerificationRequired
                    .listen((isRequired) {
                  if (isRequired) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VerifyMobileNumber()));
                  } else {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                });
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.blue,
              child: Container(
                  height: 50,
                  child: Center(
                    child: Text("Mobile Number"),
                  )))
        ]));
  }
}
