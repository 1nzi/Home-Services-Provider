import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_well/Model/CustomerModel/customerProfileModel.dart';
import 'package:home_well/View/worker/w_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'homeScreen.dart';
import '../customer/c_home.dart';

import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  Customer,
  Worker,
  notSignedIn,
}

class MySplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MySplashScreenState();
}
CustomerDataFromFireStore customerDataFromFireStore =
new CustomerDataFromFireStore();

class _MySplashScreenState extends State<MySplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  AuthStatus authStatus = AuthStatus.notSignedIn;
  SharedPreferences sp;

  @override
  void initState() {
    customerDataFromFireStore.getSharedPreferences().then((value) {
      setState(() {
        sp = value;
      });
    });
    initUser();
    super.initState();
   }

  initUser() async {
    user = await _auth.currentUser();
    if(user != null) {
      if (sp.containsKey('userId') && user.uid == sp.getString('userId'))
        setState(() {
          authStatus = AuthStatus.Customer;
          initJobs();
        }); else
      if (sp.containsKey('workerId') && user.uid == sp.getString('workerId'))
        setState(() {
          authStatus = AuthStatus.Worker;
        });
    }
  }

  initJobs() {
    customerDataFromFireStore.setJobs();
  }

  @override
  Widget build(BuildContext context) {

       Size media = MediaQuery.of(context).size;
    return new SplashScreen(
        seconds: 2,
        navigateAfterSeconds: authStatus == AuthStatus.Customer ? CustomerHomeScreen() :authStatus == AuthStatus.Worker? WorkerHome() : Home(),
        image: new Image.asset('Images/home.jpg'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: media.width * 0.50,
        loadingText: Text("Wellcome To Well Home"),
        loaderColor: Colors.lightGreen);
  }
}
