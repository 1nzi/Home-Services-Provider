
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'View/common/splashScreen.dart';


void main() async {
  return runApp(new MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'FYP',
      theme: ThemeData(
        primaryColor: Colors.lightGreen,
      ),
      home: new MySplashScreen(),
    );
  }
}