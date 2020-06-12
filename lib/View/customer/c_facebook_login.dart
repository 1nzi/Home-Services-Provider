import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:home_well/View/customer/c_select_subCategory.dart';
import'c_home.dart';


class FbLoginButon extends StatelessWidget {

  Future<FirebaseUser> _loginWithFacebook(BuildContext context) async{
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email', 'public_profile']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        //_sendTokenToServer(result.accessToken.token);
        showLoggedInUI(context);
        break;
      case FacebookLoginStatus.cancelledByUser:
        showCancelledMessage(context);
        break;
      case FacebookLoginStatus.error:
        //_showErrorOnUI(result.errorMessage);
        break;
    }
  }
  showCancelledMessage(BuildContext context){
    final snackBar = SnackBar(content: Text('You cancle the login'));
    Scaffold.of(context).showSnackBar(snackBar);
  }
  showLoggedInUI(BuildContext context) {
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => CustomerHomeScreen()));
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
          _loginWithFacebook(context);

        },
      ),
    );
  }
}

