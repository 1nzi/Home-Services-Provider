import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'homeScreen.dart';
import '../customer/c_home.dart';

import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
}

class MySplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  AuthStatus authStatus = AuthStatus.notDetermined;

  @override
  void initState() {
    initUser();
    super.initState();
   }

  initUser() async {
    user = await _auth.currentUser();
    if(user != null)
      setState(() {
        authStatus = AuthStatus.signedIn;
      });
  }

  @override
  Widget build(BuildContext context) {

       Size media = MediaQuery.of(context).size;
    return new SplashScreen(
        seconds: 2,
        navigateAfterSeconds: authStatus == AuthStatus.signedIn ? HomeScreen() : Home(),
        image: new Image.asset('Images/home.jpg'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: media.width * 0.50,
        loadingText: Text("Wellcome To Well Home"),
        loaderColor: Colors.lightGreen);
  }
}
