import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:home_well/Controller/WorkerController/rigesterWorker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'w_login.dart';
import 'w_signup_2.dart';
import 'package:path/path.dart';

class WorkerSignup1 extends StatefulWidget {
  _MySignupPageState createState() => _MySignupPageState();
}

final bucket = WorkerData();

final TextEditingController _FirstName = new TextEditingController();
final TextEditingController _Cnic = new TextEditingController();
final TextEditingController _Ph = new TextEditingController();
final TextEditingController _Email = new TextEditingController();

final FocusNode _firstNameFocus = FocusNode();
final FocusNode _cnicFocus = FocusNode();
final FocusNode _phFocus = FocusNode();
final FocusNode _emailFocus = FocusNode();
final FocusNode _nextFocus = FocusNode();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _MySignupPageState extends State<WorkerSignup1> {
  File _image;
  String profilePath;

  @override
  void initState() {
    super.initState();
    downloadImage();
    bucket.imagePath = null;
    bucket.image = null;
  }

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;

      bucket.imagePath = basename(_image.path);
      bucket.image = _image;
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
          child: Form(
        key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
              SizedBox(height: 20),

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
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _FirstName,
                  focusNode: _firstNameFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _firstNameFocus, _phFocus);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Full Name';
                    }
                    return null;
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
                child: TextFormField(
                  maxLength: 13,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  controller: _Cnic,
                  focusNode: _cnicFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _cnicFocus, _phFocus);
                  },
                  validator: (value) {
                    if (value.length < 13 ) {
                      return 'Please enter valid CNIC';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'CNIC#',
                    prefixIcon: Icon(Icons.person),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: clearCnic,
                    ),

                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 11,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: _Ph,
                  focusNode: _phFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _phFocus, _emailFocus);
                  },
                  validator: (value) {
                    if (value.length < 11 ) {
                      return 'Please enter valid Phone#';
                    }
                    return null;
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
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: _Email,
                  focusNode: _emailFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _emailFocus, _nextFocus);
                  },
                  validator: (value) {
                    if (!value.contains('@') & !value.contains('.')) {
                      return 'Please enter valid Email';
                    }
                    return null;
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
      )),
    );
  }
}

void clearText(buildContext, TextEditingController txt) {
  txt.clear();
}

void clearFirstName() {
  _FirstName.clear();
}

void clearCnic() {
  _Cnic.clear();
}

void clearPh() {
  _Ph.clear();
}

void clearEmail() {
  _Email.clear();
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
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            if (bucket.imagePath != null) {
              bucket.name = _FirstName.text;
              bucket.cnic = _Cnic.text;
              bucket.ph = _Ph.text;
              bucket.email = _Email.text;
               Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WorkerSignup2(bucket: bucket)));
            }else{
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Please Add Image"),
                duration: Duration(seconds: 5),
              ));
            }
          }
        }
      ),
    );
  }
}

void _fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
