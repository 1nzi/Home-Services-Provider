import 'package:flutter/material.dart';
import 'package:home_well/common/main.dart';
import 'package:home_well/worker/w_profile.dart';

class WorkerChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<WorkerChangePassword> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();


  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Change Your Password'),
          backgroundColor: Colors.lightGreen,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
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
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye), onPressed: _toggle),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                  ),
                  TextFormField(
                    maxLength: 15,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'New password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye), onPressed: _toggle),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                  ),
                  TextField(
                    maxLength: 15,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
                      prefixIcon: Icon(Icons.lock),
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
                          Navigator.pop(context,
                              MaterialPageRoute(builder: (context) {
                            return MyApp();
                          }));
                        },

                        //  padding: EdgeInsets.only(top: 20),
                      )),
                ],
              ),
            )),
      ),
    );
  }
}
