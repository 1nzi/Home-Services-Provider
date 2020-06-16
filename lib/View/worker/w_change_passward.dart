import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_well/Model/WorkerModel/WorkerProfileModel.dart';

import 'w_profile.dart';

WorkerDataFromFireStore updateDataFromFireStore =
new WorkerDataFromFireStore();
final TextEditingController _passw = new TextEditingController();



class WorkerChangePassword extends StatefulWidget {
  final String uid;
  final String uPassw;


  const WorkerChangePassword({Key key, this.uid, this.uPassw}) : super(key: key);

  @override
  _WorkerChangePasswordState createState() => _WorkerChangePasswordState(uid, uPassw);
}

class _WorkerChangePasswordState extends State<WorkerChangePassword> {
  final String uid;
  final String uPassw;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  bool checkCurrentPasswordValid=true;


  _WorkerChangePasswordState(this.uid, this.uPassw);
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
            'Change Your Password',
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
                  MaterialPageRoute(builder: (context) => WProfile()));
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
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if(value.length<6)
                      {
                        return  "Incorrect Password";
                      }
                    return null;
                  } ,
                  obscureText: _obscureText,
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
                  controller: _passw,
                  obscureText: _obscureText,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (value.length < 6) {
                      return 'Password should have atleast 6 digits';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'New password',
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
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (value != _passw.text) {
                      return 'Password not match';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
                    suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye), onPressed: _toggle),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Container(
                  width: 330,
                  height: 150,
                  child: Text(
                    'For security reasons,  your password needs at least 6 characters, consisting of:'
                        ' upper and lower casse latters'
                        ' numbers ',
                    style: TextStyle(
                      fontSize: 12,
                      decoration: TextDecoration.none,
                      color: Colors.grey,
                    ),
                  ),
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

                        setState(() {});
                        if (_formKey.currentState.validate() &&
                            checkCurrentPasswordValid) {

                          updateUserPassword(_passw.text);
                          updateDataFromFireStore.updateData(
                              uid, 'Password', _passw.text);
                          updateDataFromFireStore.removeValueFromSP('password');
                          updateDataFromFireStore.save('password', _passw);
                            print("iddddddddd : $uid");
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => WProfile()));
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
  void updateUserPassword(String npass){
    updatePassword(npass);

  }
  Future<void> updatePassword(String password) async {
    var firebaseUser = await _auth.currentUser();
    firebaseUser.updatePassword(password);
  }
}
