import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_well/worker/w_login.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'w_signup_2.dart';

class WorkerSignup1 extends StatefulWidget {
  _MySignupPageState createState() => _MySignupPageState();
}

final TextEditingController _clearFirstName = new TextEditingController();
final TextEditingController _clearCnic = new TextEditingController();
final TextEditingController _clearPh = new TextEditingController();
final TextEditingController _clearEmail = new TextEditingController();

final FocusNode _firstNameFocus = FocusNode();
final FocusNode _cnicFocus = FocusNode();
final FocusNode _phFocus = FocusNode();
final FocusNode _emailFocus = FocusNode();
final FocusNode _nextFocus = FocusNode();

class _MySignupPageState extends State<WorkerSignup1> {
  File _image;
  String profilePath;

  @override
  void initState() {
    super.initState();
    downloadImage();
  }

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print('Select image path' + _image.path.toString());
    });
  }

  Future downloadImage() async {
    if (profilePath != null) {
      var image = new File(profilePath);
      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(
          "Signup Page 1",
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, MaterialPageRoute(builder: (context) {
                return WorkerLogin();
              }));
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Center(
                    child: _image == null
                        ? new CircleAvatar(
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 120,
                            ),
                            radius: 65.0,
                            backgroundColor: Colors.lightGreen[200],
                          )
                        : new CircleAvatar(
                            backgroundImage: new FileImage(_image),
                            radius: 65.0,
                          ),
                  ),
                  new FloatingActionButton(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.transparent,
                    onPressed: getImage,
                    tooltip: 'Pick Image',
                    child: Icon(
                      Icons.add_a_photo,
                      size: 50,
                    ),
                  ),
                ]),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: _clearFirstName,
                focusNode: _firstNameFocus,
                onSubmitted: (term) {
                  _fieldFocusChange(context, _firstNameFocus, _phFocus);
                },
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: clearFirstName,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 13,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                controller: _clearCnic,
                focusNode: _cnicFocus,
                onSubmitted: (term) {
                  _fieldFocusChange(context, _cnicFocus, _phFocus);
                },
                decoration: const InputDecoration(
                  labelText: 'CNIC#',
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: clearLastName,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 11,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                controller: _clearPh,
                focusNode: _phFocus,
                onSubmitted: (term) {
                  _fieldFocusChange(context, _phFocus, _emailFocus);
                },
                decoration: const InputDecoration(
                  labelText: 'Phone#',
                  prefixIcon: Icon(Icons.phone),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: clearPh,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: _clearEmail,
                focusNode: _emailFocus,
                onSubmitted: (term) {
                  _fieldFocusChange(context, _emailFocus, _nextFocus);
                },
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: clearEmail,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            NextButton()
          ],
        ),
      ),
    );
  }
}

void clearText(buildContext, TextEditingController txt) {
  txt.clear();
}

void clearFirstName() {
  _clearFirstName.clear();
}

void clearLastName() {
  _clearCnic.clear();
}

void clearPh() {
  _clearPh.clear();
}

void clearEmail() {
  _clearEmail.clear();
}

class NextButton extends StatelessWidget {
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
        focusNode: _nextFocus,
        child: Text(
          "Next",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => WorkerSignup2()));
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
