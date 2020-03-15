import 'package:flutter/material.dart';
import 'file:///C:/Users/Saad/fyp/lib/Model/CustomerModel/customerProfileModel.dart';

import 'c_profile.dart';

CustomerDataFromFireStore updateDataFromFireStore =
    new CustomerDataFromFireStore();

class Mobile extends StatefulWidget {
  final String uid;

  const Mobile({Key key, this.uid}) : super(key: key);

  @override
  _MobileState createState() => _MobileState(uid);
}

final TextEditingController _ph = new TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _MobileState extends State<Mobile> {
  final String uid;

  _MobileState(this.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Update Number',
            style: new TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.lightGreen,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, MaterialPageRoute(builder: (context) {
                  return Profile();
                }));
              }),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Update your mobile number',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      // fontFamily: 'Raleway',
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text(
                  'We will send a code to your new mobile numebr to verify your account',
                  style: TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.none,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                TextFormField(
                  controller: _ph,
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  decoration: InputDecoration(
                    hintText: '0301 2345678',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter valid Phone';
                    }
                    if (value.length < 11) {
                      return 'Please enter valid Phone';
                    }
                    return null;
                  },
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
                          updateDataFromFireStore.updateData(
                              uid, 'Phone', _ph.text);
                          Navigator.pop(context,
                              MaterialPageRoute(builder: (context) {
                                return Profile();
                              }));
                        }
                      },

                      //  padding: EdgeInsets.only(top: 20),
                    )),
              ],
            ),
          ),
        ));
  }
}
