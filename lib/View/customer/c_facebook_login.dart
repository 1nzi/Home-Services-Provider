import 'package:flutter/material.dart';
import 'package:home_well/View/customer/c_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:home_well/View/customer/c_select_subCategory.dart';


class FbLoginBuuton extends StatelessWidget {

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLogged = false;

  FirebaseUser myUser;

  Future<FirebaseUser> _loginWithFacebook() async {
    var facebookLogin = new FacebookLogin();

    final FacebookLoginResult facebookLoginResult = await facebookLogin.logIn(['email', 'public_profile']);
    FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
    AuthCredential authCredential = FacebookAuthProvider.getCredential(accessToken: facebookAccessToken.token);
    FirebaseUser fbUser;
    fbUser = (await _auth.signInWithCredential(authCredential)).user;
  }

  void _logIn(BuildContext context) {
    _loginWithFacebook().then((response) {
      if (response != null) {
        myUser = response;
        isLogged = true;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SelectSubCategory()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 40.0,
      child: RaisedButton(
        elevation: 6.0,
        padding: EdgeInsets.all(8.0),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
        textColor: Colors.white,
        color: Color.fromRGBO(57, 86, 148, 1.0),
        child: Text(
          "Login With Facebook",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        onPressed: () {
          _logIn(context);

        },
      ),
    );
  }
}

