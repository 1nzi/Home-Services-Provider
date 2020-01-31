import 'package:flutter/material.dart';

import 'c_profile.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();


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
            title: Text('Change Your Password',
              style: new TextStyle(
                  fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.lightGreen,
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
          body: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value.isEmpty && value.length<5) {
                        return 'Password should have atleast 5 digits';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Current password',
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
                      'For security reasons,  your password needs at least 8 characters, consisting of:'
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
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Navigator.pop(context, MaterialPageRoute(builder: (context) {
                              return Profile();
                            }));
                          }
                        }),

                        //  padding: EdgeInsets.only(top: 20),
                      ),
                ],
              ),
            ),
          )
    );
  }
}
