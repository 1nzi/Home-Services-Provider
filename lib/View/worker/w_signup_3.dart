import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_well/Controller/WorkerController/rigesterWorker.dart';
import 'package:home_well/Model/RigesterWorkerModel.dart';
import 'package:home_well/View/worker/w_signup_1.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../common/homeScreen.dart';

class WorkerSignup3 extends StatefulWidget {
  final WorkerData bucket;

  const WorkerSignup3({Key key, this.bucket}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MySignupPageState();
  }
}

final TextEditingController _password = new TextEditingController();
final TextEditingController _confirmPassword = new TextEditingController();
final FocusNode _passwordFocus = FocusNode();
final FocusNode _confirmpasswordFocus = FocusNode();
final FocusNode _SignupButtonFocus = FocusNode();
final _formKey = GlobalKey<FormState>();

class _MySignupPageState extends State<WorkerSignup3> {
  File _frontCNIC ;
  File _backCNIC ;
  String profilePath;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    downloadFrontImage();
    downloadBackImage();
    bucket.cnicFrontPath = null;
    bucket.cnicBackPath = null;
    bucket.cnicFrontimage = null;
    bucket.cnicBackimage = null;
  }

  Future getFrontImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _frontCNIC = image;
      bucket.cnicFrontPath = basename(_frontCNIC.path);
      bucket.cnicFrontimage = _frontCNIC;

      print('Select image path' + _frontCNIC.path.toString());
    });
  }

  Future getBackImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _backCNIC = image;
      bucket.cnicBackPath = basename(_backCNIC.path);
      bucket.cnicBackimage = _backCNIC;

      print('Select image path' + _backCNIC.path.toString());
    });
  }

  Future downloadFrontImage() async {
    if (profilePath != null) {
      var frontImage = new File(profilePath);
      setState(() {
        _frontCNIC = frontImage;
      });
    }
  }

  Future downloadBackImage() async {
    if (profilePath != null) {
      var backImage = new File(profilePath);
      setState(() {
        _backCNIC = backImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Signup Page 3",
            style: new TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.lightGreen,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  new Center(
                      child: _frontCNIC == null
                          ? new Icon(
                              Icons.camera_front,
                              color: Colors.lightGreen[200],
                              size: 120,
                            )
                          : new Container(
                              child: Image(
                                image: FileImage(_frontCNIC),
                                width: 200,
                                height: 130,
                                fit: BoxFit.fill,
                              ),
                            )),
                  new RaisedButton(
                    onPressed: getFrontImage,
                    elevation: 6.0,
                    textColor: Colors.white,
                    color: Colors.lightGreen,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      'Upload CNIC Front Image',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  new Center(
                      child: _backCNIC == null
                          ? new Icon(
                              Icons.camera_front,
                              color: Colors.lightGreen[200],
                              size: 120,
                            )
                          : new Container(
                              child: Image(
                                image: FileImage(_backCNIC),
                                width: 200,
                                height: 130,
                                fit: BoxFit.fill,
                              ),
                            )),
                  new RaisedButton(
                    onPressed: getBackImage,
                    elevation: 6.0,
                    textColor: Colors.white,
                    color: Colors.lightGreen,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      'Upload CNIC Back Image',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black12,
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: _password,
                      focusNode: _passwordFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(
                            context, _passwordFocus, _confirmpasswordFocus);
                      },
                      validator: (value) {
                        if (value.length < 6) {
                          return 'Password should have atleast 6 digits';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: _toggle),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: _confirmPassword,
                      focusNode: _confirmpasswordFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(
                            context, _confirmpasswordFocus, _SignupButtonFocus);
                      },
                      validator: (value) {
                        if (value != _password.text) {
                          return 'Password not match';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'confirm Password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: _toggle),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SignupButton()
                ],
              ),
            ),
          ),
        ));
  }
}

class SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 40.0,
      child: RaisedButton(
        focusNode: _SignupButtonFocus,
        elevation: 6.0,
        textColor: Colors.white,
        color: Colors.lightGreen,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
        child: Text(
          "Signup",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            if (bucket.cnicFrontimage == null) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Please Add CNIC Front Image"),
                duration: Duration(seconds: 5),
              ));
            } else if (bucket.cnicBackimage == null) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Please Add CNIC Back Image"),
                duration: Duration(seconds: 5),
              ));
            } else {
              bucket.password = _password.text;
              String result = await registerUser(bucket);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(result),
                duration: Duration(seconds: 5),
              ));
              if (result == 'Signup Successfully') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }
            }
          }
        },
      ),
    );
  }
}

void _fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

Future registerUser(WorkerData bucket) async {
  try {
    AuthResult authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: bucket.email, password: bucket.password);
    FirebaseUser user = authResult.user;
    //create document for customer with customerId
    DatabaseService(uid: user.uid).updateWorkerData(bucket);
    return 'Signup Successfully';
  } catch (signUpError) {
    print(signUpError.toString());
    return signUpError.code;
  }
}
