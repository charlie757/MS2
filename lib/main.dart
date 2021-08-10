import 'package:flutter/material.dart';
import 'package:flutter_truecaller/flutter_truecaller.dart';
import 'package:truecaller_flutter_app/Pages/OnBordingPage/GettingStarted.dart';
import 'package:truecaller_flutter_app/Pages/verify_mobile_number.dart';

import 'Pages/LoginPage.dart';
import 'Pages/home_page.dart';

void main() => runApp(
      MaterialApp(
        home: MyApp(),
        debugShowCheckedModeBanner: false,
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GettingStartedScreen();
  }
}
