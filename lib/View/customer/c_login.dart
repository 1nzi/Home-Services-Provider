import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../common/authentication.dart';
import 'c_drawer.dart';
import 'c_home.dart';
import 'c_signup_1.dart';

class CustomerLogin extends StatefulWidget {

  @override
  _CustomerLoginState createState() => _CustomerLoginState();
}


class _CustomerLoginState extends State<CustomerLogin> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _ph, _passw;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text("Customer Login",
            style: new TextStyle(
                fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: new InkWell(
            borderRadius: BorderRadius.circular(30.0),
            child: new Icon(
              Icons.arrow_back,
              color: Colors.black54,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                ImageAsset(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(

                    maxLength: 11,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],

                    decoration: const InputDecoration(
                      labelText: 'Phone No.',
                      hintText: '03001234567',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),

                    validator: (value) {
                      if (value.isEmpty && value.length<11 ) {
                        return 'Please enter valid Phone No.';
                      }else if(!value.contains('03004046580'))
                        {
                          return 'This Phone No. is not Registered';
                        }
                      return null;
                    },
                    onSaved: (value)=> _ph = value,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter valid Password';
                      }
                      return null;
                    },
                    onSaved: (value)=> _passw = value,

                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
             Container(
              width: 200.0,
              height: 40.0,
              child: RaisedButton(
                  elevation: 6.0,
                  textColor: Colors.white,
                  color: Colors.lightGreen,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      dynamic result = signin();

                      if (result == null) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Invalid User Credential'),
                            duration: Duration(seconds: 3),
                        ));
                      } else {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomerHome()));
                      }
                    }
                  }
              ),
            ),
                new FlatButton(
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                    onPressed: () => _showAlert(context)),
                Row(children: <Widget>[
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                        child: Divider(
                          color: Colors.black,
                          height: 50,
                        )),
                  ),
                  Text("OR"),
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                        child: Divider(
                          color: Colors.black,
                          height: 50,
                        )),
                  ),
                ]),
                SizedBox(
                  height: 10,
                ),
                FbLoginBuuton(),
                SizedBox(
                  height: 10,
                ),
                GmailLoginBuuton(),
                new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerSignup1()));
                  },
                  child: Text('Not a member? Sign up now',
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ),
        ));
  }

  Future <void> signin() async{
     try {
        AuthResult authResult = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _ph, password: _passw);
        FirebaseUser user = authResult.user;
        return user;
      }catch(e) {
        print(e.toString());
        return null;
      }
    }
    }



class FbLoginBuuton extends StatelessWidget {
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CustomerHome()));
        },
      ),
    );
  }
}

class GmailLoginBuuton extends StatelessWidget {
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CustomerHome()));
        },
      ),
    );
  }
}

void _showAlert(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Forget Password!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.send,
                  decoration: const InputDecoration(
                    labelText: 'Enter Phone No.',
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Send Code'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Otp(
                            phone: '03004046580',
                          )));
            },
          ),
        ],
      );
    },
  );
}
