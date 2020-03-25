import 'package:flutter/material.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomerCtrl.dart';
import 'file:///C:/Users/Saad/fyp/lib/Model/CustomerModel/customerProfileModel.dart';

import 'c_profile.dart';

CustomerDataFromFireStore updateDataFromFireStore = new CustomerDataFromFireStore();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _name = new TextEditingController();


class UpdateName extends StatefulWidget {
  final CustomerData user;

  const UpdateName({Key key, this.user}) : super(key: key);

  @override
  _UpdateNameState createState() => _UpdateNameState(user);
}


class _UpdateNameState extends State<UpdateName> {
   CustomerData user;

  _UpdateNameState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Update Your Name',
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
                  return Profile(user: user,);
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
                Text('Update your name',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      //              fontFamily: 'Raleway',
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text(
                  'Your name makes it easy for Workers to confirm who they are working for',
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
                  controller: _name,
                  decoration: InputDecoration(
                    hintText: 'Enter your full name',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Name';
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
                      onPressed: ()async {
                        if (_formKey.currentState.validate()) {
                          updateDataFromFireStore.updateData(
                              user.userId, 'Name', _name.text);
                          user.fname = _name.text;
                          Navigator.pop(context,
                              MaterialPageRoute(builder: (context) {
                            return new Profile(user: user,);
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
