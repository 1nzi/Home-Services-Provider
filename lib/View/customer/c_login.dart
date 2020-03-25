import 'package:double_back_to_close_app/double_back_to_close_app.dart';
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

final TextEditingController _email = new TextEditingController();
final TextEditingController _password = new TextEditingController();
final _scaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _CustomerLoginState extends State<CustomerLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text(
            "Customer Login",
            style: new TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          leading: new InkWell(
            borderRadius: BorderRadius.circular(30.0),
            child: new Icon(
              Icons.arrow_back,
              color: Colors.black54,
            ),
            onTap: () {
              //Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),
        body: DoubleBackToCloseApp(
            snackBar: const SnackBar(
              content: Text('Tap back again to leave'),
              backgroundColor: Colors.lightGreen,
            ),
            child: SingleChildScrollView(
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
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'abc@gmail.com',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (!value.contains('@') && !value.contains('.')) {
                            return 'Please enter valid Email.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _password,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid Password';
                          }
                          return null;
                        },
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
                    LoginBuuton(),
                    new FlatButton(
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.lightBlueAccent),
                        ),
                        onPressed: () => _showAlert(context)),
                    Row(children: <Widget>[
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 15.0),
                            child: Divider(
                              color: Colors.black,
                              height: 50,
                            )),
                      ),
                      Text("OR"),
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 15.0, right: 10.0),
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
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CustomerSignup1()));
                      },
                      child: Text('Not a member? Sign up now',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ),
            )));
  }
}

class LoginBuuton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          if (_formKey.currentState.validate()) {
            dynamic result = await signin();

            if (result is FirebaseUser) {
              _email.clear();
              _password.clear();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => CustomerHome()));
            } else {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Incorrect Email Address or Password'),
                duration: Duration(seconds: 3),
              ));
            }
          }
        },
      ),
    );
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

Future signin() async {
  try {
    AuthResult authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _email.text, password: _password.text);
    FirebaseUser user = authResult.user;
    return user;
  } catch (signinError) {
    print(signinError.toString());
    return null;
  }
}
