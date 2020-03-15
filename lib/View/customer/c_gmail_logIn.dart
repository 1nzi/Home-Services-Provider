import 'package:google_sign_in/google_sign_in.dart';


class GmailLogin {

  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<bool> login() async{
    try{
      await _googleSignIn.signIn();
        _isLoggedIn = true;
      return _isLoggedIn;
    } catch (err){
      print(err);
    }
  }

  Future<bool> logout() async {
    try {
      await _googleSignIn.signOut();
      _isLoggedIn = false;
      return _isLoggedIn;
    } catch (err) {
      print(err);
    }
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

  }