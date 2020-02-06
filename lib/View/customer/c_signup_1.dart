import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomer.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'c_signup_2.dart';

class CustomerSignup1 extends StatefulWidget {
  _MySignupPageState createState() => _MySignupPageState();
}
final data= CustomerData ();

final TextEditingController _clearFirstName = new TextEditingController();
final TextEditingController _clearLastName = new TextEditingController();
final TextEditingController _clearPh = new TextEditingController();
final TextEditingController _clearEmail = new TextEditingController();

final FocusNode _firstNameFocus = FocusNode();
final FocusNode _lastNameFocus = FocusNode();
final FocusNode _phFocus = FocusNode();
final FocusNode _emailFocus = FocusNode();
final FocusNode _nextFocus = FocusNode();

String name;
class _MySignupPageState extends State<CustomerSignup1> {
  File _image;
  String profilePath;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
          'Signup Page 1',
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _clearFirstName,
                  focusNode: _firstNameFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _firstNameFocus, _lastNameFocus);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter First Name';
                    }
                    return null;
                  },
                  onChanged: (value)=> print(value),

                  decoration: const InputDecoration(
                    labelText: 'First Name',
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
                  textInputAction: TextInputAction.next,
                  controller: _clearLastName,
                  focusNode: _lastNameFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _lastNameFocus, _phFocus);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter last Name';
                    }
                    return null;
                  },
                  onSaved: (value)=> data.lname = value,

                  decoration: const InputDecoration(
                    labelText: 'Last Name',
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
                child: TextFormField(
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: _clearPh,
                  focusNode: _phFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _phFocus, _emailFocus);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Phone#';
                    }
                    return null;
                  },
                  onSaved: (value)=> data.ph = value,

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
                  controller: _clearEmail,
                  focusNode: _emailFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _emailFocus, _nextFocus);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Email';
                    }
                    return null;
                  },
                  onSaved: (value)=> data.email = value,

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
  _clearLastName.clear();
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
          print(_clearFirstName.text);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CustomerSignup2(data: data)));
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
