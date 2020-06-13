import 'package:flutter/material.dart';
import 'package:home_well/Model/CustomerModel/customerProfileModel.dart';

import 'c_profile.dart';


CustomerDataFromFireStore updateDataFromFireStore =
new CustomerDataFromFireStore();

class UpdateEmail extends StatefulWidget {
  final String uid;

  const UpdateEmail({Key key, this.uid}) : super(key: key);
  @override
  _UpdateEmailState createState() => _UpdateEmailState(uid);
}

final TextEditingController _email = new TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _UpdateEmailState extends State<UpdateEmail> {
  final String uid;

  _UpdateEmailState(this.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Update Email',
            style: new TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.lightGreen,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Update your email',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text(
                  'Receive info about new updates and awesome promos in your inbox',
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
                  controller: _email,
                  decoration: InputDecoration(
                    hintText: 'Enter your new email address',
                    hintStyle: TextStyle(),
                  ),
                  validator: (value) {
                    if (!value.contains('@')) {
                      return 'Please enter valid Email';
                    }
                    if (!value.contains('.')) {
                      return 'Please enter valid Email';
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
                              uid, 'Email', _email.text);
                          updateDataFromFireStore.removeValueFromSP('email');
                          updateDataFromFireStore.save('email', _email.text);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => Profile()));

                        }
                      }, //  padding: EdgeInsets.only(top: 20),
                    )),
              ],
            ),
          ),
        ));
  }
}
