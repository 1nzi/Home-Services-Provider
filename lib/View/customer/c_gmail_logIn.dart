
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_well/Model/GmailLogInCustomerModel.dart';
import 'package:home_well/View/customer/c_select_subCategory.dart';


class GmailLoginBuuton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GmailLoginBuutonState();
  }
}
class _GmailLoginBuutonState extends State<GmailLoginBuuton> {

  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async{
    try{
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
    } catch (err){
      print(err);
    }
  }

  _logout(){
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }
  /*final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn(BuildContext context) async {

    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('Sign in'),
    ));

    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

   // FirebaseUser userDetails = await _firebaseAuth.signInWithCredential(credential)as FirebaseUser;
   // ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);

    /*List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);

    UserDetails details = new UserDetails(
      userDetails.providerId,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    );*/
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new SelectSubCategory(),
      ),
    );
    //return userDetails;
  }*/






  /*final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<bool> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if(account == null )
        return false;
      AuthResult res = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      if(res.user == null)
        return false;
      return true;
    } catch (e) {
      print("Error logging with google");
      return false;
    }
  }*/

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
          color: Color.fromRGBO(217, 83, 79, 1.0),
          child: Text(
            "Login With Google",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          onPressed: () {
            _login();
          if(_isLoggedIn)
          {
            Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new SelectSubCategory(),
            ),
          );
          }
          else{
            Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text('Not Sign in'),
            ));
          }
          }
      ),
    );
  }

}
