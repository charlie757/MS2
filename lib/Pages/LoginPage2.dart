import 'package:flutter/material.dart';

import 'package:truecaller_sdk/truecaller_sdk.dart';
import 'package:truecaller_flutter_app/Pages/verify_mobile_number.dart';

class LoginPage2 extends StatefulWidget {
  const LoginPage2({Key key}) : super(key: key);

  @override
  _LoginPage2State createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  Stream<TruecallerSdkCallback> _stream;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    this.getTrueCaller();
    _stream = TruecallerSdk.streamCallbackData;
  }

  Future getTrueCaller() async {
    await TruecallerSdk.initializeSDK(
        sdkOptions: TruecallerSdkScope.SDK_OPTION_WITH_OTP);
    TruecallerSdk.isUsable.then((isUsable) {
      if (isUsable) {
        TruecallerSdk.getProfile;
      } else {
        final snackBar = SnackBar(content: Text("Not Usable"));
        _scaffoldKey.currentState.showSnackBar(snackBar);
        print("***Not usable***");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Truecaller SDK example'),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    getTrueCaller();
                  },
                  child: Text(
                    "Initialize SDK & Get Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                ),
                Divider(
                  color: Colors.transparent,
                  height: 20.0,
                ),
                StreamBuilder<TruecallerSdkCallback>(
                    stream: _stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data.result) {
                          case TruecallerSdkCallbackResult.success:
                            return Text(
                                "Hi, ${snapshot.data.profile.firstName} ${snapshot.data.profile.lastName}"
                                "\nBusiness Profile: ${snapshot.data.profile.isBusiness}");
                          case TruecallerSdkCallbackResult.failure:
                            return Text(
                                "Oops!! Error type ${snapshot.data.error.code}");
                          case TruecallerSdkCallbackResult.verification:
                            return Column(
                              children: [
                                Text("Verification Required : "
                                    "${snapshot.data.error != null ? snapshot.data.error.code : ""}"),
                                MaterialButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VerifyMobileNumber()));
                                  },
                                  child: Text(
                                    "Do manual verification",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            );
                          default:
                            return Text("Invalid result");
                        }
                      } else
                        return Text("");
                    }),
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    _stream = null;
    super.dispose();
  }
}
