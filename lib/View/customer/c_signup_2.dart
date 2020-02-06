import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomer.dart';
import 'package:home_well/View/customer/c_signup_1.dart';
import 'c_login.dart';


class CustomerSignup2 extends StatefulWidget {
  final CustomerData data;

  const CustomerSignup2({Key key, this.data}) : super(key: key);

  _MySignupPageState createState() => _MySignupPageState();
}

final TextEditingController _clearStreetAdd = new TextEditingController();
final FocusNode _addressFocus = FocusNode();
final FocusNode _passwordFocus = FocusNode();

class _MySignupPageState extends State<CustomerSignup2> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  String pass;


  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // ignore: non_constant_identifier_names
  String City = 'Lahore';

  // ignore: non_constant_identifier_names
  String Area = 'DHA';

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
              Padding(
                  padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
                  child: DropdownButton<String>(
                    value: City,
                    icon: Icon(
                      Icons.location_city,
                      color: Colors.lightGreen,
                      size: 24,
                    ),
                    isExpanded: true,
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                    onChanged: (String newValue) {
                      setState(() {
                        City = newValue;
                        data.city = City;
                      });
                    },
                    items: <String>[
                      'Lahore',
                      'Krachi',
                      'Multan',
                      'Islamabad',
                      'Faislabad',
                    ].map<DropdownMenuItem<String>>((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                "Select Area",
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
                  child: DropdownButton<String>(
                    hint: Text('Select Area'),
                    value: Area,
                    icon: Icon(Icons.location_city,
                        color: Colors.lightGreen, size: 24),
                    isExpanded: true,
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                    onChanged: (String newValue) {
                      setState(() {
                        Area = newValue;
                        data.area = newValue;
                      });
                    },
                    items: <String>[
                      'DHA',
                      'Samnabad',
                      'Shadman',
                      'Johar Town',
                      'Muslim Town',
                      'Anarkali',
                      'MughalPura'
                    ].map<DropdownMenuItem<String>>((String area) {
                      return DropdownMenuItem<String>(
                        value: area,
                        child: Text(area),
                      );
                    }).toList(),
                  )),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  controller: _clearStreetAdd,
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
                  onSaved: (value)=> data.address = value,

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
                  validator: (value) {
                    if (value.isEmpty && value.length < 5) {
                      return 'Password should have atleast 5 digits';
                    }
                    return null;
                  },
                  onSaved: (value)=>data.password = value,


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
                  validator: (value) {
                    if (value != data.password) {
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
          print(data.fname);
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CustomerLogin()));
        },
      ),
    );
  }
}

void clearAddress() {
  _clearStreetAdd.clear();
}

void _fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
