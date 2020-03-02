import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomer.dart';
import 'package:home_well/Model/RigesterCustomerModel.dart';
import 'package:home_well/View/customer/c_signup_1.dart';
import 'c_login.dart';


class CustomerSignup2 extends StatefulWidget {
  final CustomerData bundle;

  const CustomerSignup2({Key key, this.bundle}) : super(key: key);

  _MySignupPageState createState() => _MySignupPageState();
}

final TextEditingController _streetAdd = new TextEditingController();
final TextEditingController _password = new TextEditingController();
final TextEditingController _confirmPassword = new TextEditingController();
final FocusNode _addressFocus = FocusNode();
final FocusNode _passwordFocus = FocusNode();
final FocusNode _confirmpasswordFocus = FocusNode();
final FocusNode _SignupButtonFocus = FocusNode();
final _formKey = GlobalKey<FormState>();

// ignore: non_constant_identifier_names
String City = 'Lahore';

// ignore: non_constant_identifier_names
String Area ;

class _MySignupPageState extends State<CustomerSignup2> {
  bool _obscureText = true;



  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text( "Signup Page 2",
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "Select City",
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("City").snapshots(),
                  builder: (context, snapshot) {
                    List<DropdownMenuItem<String>> city = new List();
                    if (!snapshot.hasData) {
                      return Text("No City Found");
                    } else {
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        city.add(
                          DropdownMenuItem(
                            child: Text(snap.documentID),
                            value: "${snap.documentID}",
                          ),
                        );
                      }
                      return Padding(
                          padding: EdgeInsets.fromLTRB(18, 0, 18, 10),
                          child: DropdownButton<String>(
                            icon: Icon(
                              Icons.location_city,
                              color: Colors.lightGreen,
                              // ignore: missing_return
                              size: 24,
                            ),
                            style:
                            TextStyle(color: Colors.black, fontSize: 18.0),
                            isExpanded: true,
                            value: City,
                            items: city,
                            onChanged: (String newValue) {
                              setState(() {
                                City = newValue;
                                bundle.city = newValue;
                                Area = null;
                              });
                            },
                          ));
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              Text(
                "Select Area",
              ),
              StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance
                      .collection("City")
                      .document(City)
                      .get()
                      .asStream(),
                  builder: (context, snapshot) {
                    List<String> area = new List();
                    if (!snapshot.hasData) {
                      return Text("Loading...");
                    } else {
                      area = List.from(snapshot.data['Area']);

                      return Padding(
                          padding: EdgeInsets.fromLTRB(18, 0, 18, 10),
                          child: DropdownButtonFormField<String>(
                            icon: Icon(
                              Icons.location_city,
                              color: Colors.lightGreen,
                              // ignore: missing_return
                              size: 24,
                            ),
                            style:
                            TextStyle(color: Colors.black, fontSize: 18.0),
                            isExpanded: true,
                            hint: new Text("Select Area"),
                            items: area
                                .map<DropdownMenuItem<String>>((String area) {
                              return DropdownMenuItem<String>(
                                value: area,
                                child: Text(area),
                              );
                            }).toList(),
                            onChanged: (String newValue) {
                              setState(() {
                                Area = newValue;
                                bundle.area = newValue;
                              });
                            },
                            validator: (newVal) {
                              if (newVal == null) {
                                return 'Area is required';
                              }
                              return null;
                            },
                            value: Area,
                          ));
                    }
                  }),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  controller: _streetAdd,
                  focusNode: _addressFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _addressFocus, _passwordFocus);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Street Address';
                    }
                    return null;
                  },

                  decoration: const InputDecoration(
                    labelText: 'Street Address',
                    prefixIcon: Icon(Icons.location_city),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: clearAddress,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Divider(
                color: Colors.black12,
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: _obscureText,
                  controller: _password,
                  focusNode: _passwordFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _passwordFocus, _confirmpasswordFocus);
                  },
                  validator: (value) {
                    if ( value.length < 6) {
                      return 'Password should have atleast 6 digits';
                    }
                    return null;
                  },

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
                  obscureText: _obscureText,
                  controller: _confirmPassword,
                  focusNode: _confirmpasswordFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _confirmpasswordFocus, _SignupButtonFocus);
                  },validator: (value) {
                  if (value != _password.text) {
                    return 'Password not match';
                  }
                  return null;
                },
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
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
            bundle.city = City;
            bundle.area = Area;
            bundle.address = _streetAdd.text;
            bundle.password = _password.text;
            bundle.jobCount = 0;
            String result =await registerUser(bundle);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(result),
              duration: Duration(seconds: 5),
            ));
            if(result=='Signup Successfully'){
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CustomerLogin()));
            }
          }
        },
      ),
    );
  }
}

void clearAddress() {
  _streetAdd.clear();
}

void _fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

Future registerUser(CustomerData bundle) async{
  try {
    AuthResult authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: bundle.email, password: bundle.password);
    FirebaseUser user = authResult.user;
    //create document for customer with customerId
    DatabaseService(uid: user.uid).updateCustomerData(bundle);
    return 'Signup Successfully';

  }catch(signUpError) {
    print(signUpError.toString());
    return signUpError.code;
  }
}