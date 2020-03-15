import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'homeScreen.dart';

class MySplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: HomeScreen(),
        image: new Image.asset('Images/home.jpg'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: media.width*0.50,
        loadingText: Text("Wellcome To Well Home"),
        loaderColor: Colors.lightGreen
    );
  }
}