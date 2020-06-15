import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_well/Model/CustomerModel/customerProfileModel.dart';

import 'c_profile.dart';

CustomerDataFromFireStore updateDataFromFireStore =
new CustomerDataFromFireStore();
final TextEditingController _email = new TextEditingController();



class CUpdateEmail extends StatefulWidget {
  final String uid;
  final String uemail;


  const CUpdateEmail({Key key, this.uid, this.uemail}) : super(key: key);

  @override
  _CUpdateEmailState createState() => _CUpdateEmailState(uid, uemail);
}

class _CUpdateEmailState extends State<CUpdateEmail> {
  final String uid;
  final String uemail;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  bool checkCurrentPasswordValid=true;


  _CUpdateEmailState(this.uid, this.uemail);
  var _currpassw = TextEditingController();


  void dispose() {
    _currpassw.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Change Your Email',
            style: new TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.lightGreen,
          leading: new InkWell(
            borderRadius: BorderRadius.circular(30.0),
            child: new Icon(
              Icons.arrow_back,
              color: Colors.black54,
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  validator:( value){
                    if(value.length<6)
                    {
                      return  "Incorrect Password";
                    }
                    return null;
                  } ,
                  decoration: InputDecoration(

                    labelText: "Password",
                    errorText: checkCurrentPasswordValid
                        ? null
                        : "Please double check your current password",
                  ),
                  controller: _currpassw,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                TextFormField(
                  controller: _email,
                  obscureText: _obscureText,
                  validator: (value) {
                    if (!value.contains('@')) {
                      return 'Please enter valid Email';
                    }
                    if (!value.contains('.')) {
                      return 'Please enter valid Email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'New Email',
                    suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye), onPressed: _toggle),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                TextFormField(
                  obscureText: _obscureText,
                  validator: (value) {
                    if (value != _email.text) {
                      return 'Email not match';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Confirm Email',
                    suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye), onPressed: _toggle),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Container(
                  width: 330,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.lightGreen)),
                      color: Colors.lightGreen,
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () async {
                        checkCurrentPasswordValid= await validateCurrentPassword(_currpassw.text);
                        print("iddddddddddddddd: $uid");
                        print(checkCurrentPasswordValid);


                        setState(() {});
                        if (_formKey.currentState.validate() &&
                            checkCurrentPasswordValid) {
                           print("iddddddddddddddd: $uid");
                          updateUserEmail(_email.text);
                          updateDataFromFireStore.updateData(
                              uid, 'Email', _email.text);
                          updateDataFromFireStore.removeValueFromSP('email');
                          updateDataFromFireStore.save('email', _email);

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                        }
                      }),

                  //  padding: EdgeInsets.only(top: 20),
                ),
              ],
            ),
          ),
        ));
  }



  Future<bool> validateCurrentPassword(String passwd)async{

    return await validatePassword(passwd);

  }


  Future<bool> validatePassword(String password)async {
    var  firebaseUser = await _auth.currentUser();
    var authCredentials=EmailAuthProvider.getCredential(email: firebaseUser.email, password:password );
    try {
      var authResult = await firebaseUser
          .reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void updateUserEmail(String nEmail){
    updateEmail(nEmail);

  }
  Future<void> updateEmail(String email) async {
    var firebaseUser = await _auth.currentUser();
    firebaseUser.updateEmail(email);
  }
}
