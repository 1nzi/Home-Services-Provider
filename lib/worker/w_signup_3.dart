import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_well/common/homeScreen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class WorkerSignup3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MySignupPageState();
  }
}

class _MySignupPageState extends State<WorkerSignup3> {
  File _frontCNIC;
  File _backCNIC;
  String profilePath;
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();

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
  }

  Future getFrontImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _frontCNIC = image;
      print('Select image path' + _frontCNIC.path.toString());
    });
  }

  Future getBackImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _backCNIC = image;
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
        title: Text("Signup Page 3",
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightGreen,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye), onPressed: _toggle),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  // controller: _textController,
                  decoration: InputDecoration(
                    labelText: 'confirm Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye), onPressed: _toggle),
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
    );
  }
}

class SignupButton extends StatelessWidget {
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
          "Signup",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
      ),
    );
  }
}
