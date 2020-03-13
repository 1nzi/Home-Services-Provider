import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomerCtrl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'c_signup_2.dart';
import 'package:path/path.dart';

class CustomerSignup1 extends StatefulWidget {
  _MySignupPageState createState() => _MySignupPageState();
}

final bundle = CustomerData();

final TextEditingController _name = new TextEditingController();
final TextEditingController _Ph = new TextEditingController();
final TextEditingController _Email = new TextEditingController();

final FocusNode _nameFocus = FocusNode();
final FocusNode _phFocus = FocusNode();
final FocusNode _emailFocus = FocusNode();
final FocusNode _nextFocus = FocusNode();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _MySignupPageState extends State<CustomerSignup1> {
  File _image ;
  String profilePath;
  static const List<String> gender = const ['Male', 'Female'];
  String Gender = gender[0];

  @override
  void initState() {
    super.initState();
    downloadImage();
    bundle.imagePath = null;
    bundle.image = null;
  }

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      bundle.imagePath = basename(_image.path);
      bundle.image = _image;
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
                        child: Image.network(
                            "https://previews.123rf.com/images/tuktukdesign/tuktukdesign1606/tuktukdesign160600105/59070189-user-icon-man-profile-businessman-avatar-person-icon-in-vector-illustration.jpg"),
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
                  controller: _name,
                  focusNode: _nameFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _nameFocus, _phFocus);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter First Name';
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
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: _Ph,
                  focusNode: _phFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _phFocus, _emailFocus);
                  },
                  validator: (value) {
                    if (value.length < 11) {
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
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Container(
                    height: 55,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: Colors.black38),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                    child: DropdownButton<String>(
                      hint: Text(' Select Gender'),
                      value: Gender,
                      icon: Icon(Icons.person,
                          color: Colors.lightGreen, size: 24),
                      isExpanded: true,
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                      onChanged: (String newValue) {
                        setState(() {
                          Gender = newValue;
                          bundle.gender = newValue;
                        });
                      },
                      items: gender.map((string) {
                        return new DropdownMenuItem(
                          child: new Text(
                            string,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: string,
                        );
                      }).toList(),
                    )),
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
            bundle.fname = _name.text;
            bundle.ph = _Ph.text;
            bundle.email = _Email.text;
            print(bundle.imagePath);
            print(bundle.image);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerSignup2(bundle: bundle)));
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

void clearFirstName() {
  _name.clear();
}

void clearPh() {
  _Ph.clear();
}

void clearEmail() {
  _Email.clear();
}