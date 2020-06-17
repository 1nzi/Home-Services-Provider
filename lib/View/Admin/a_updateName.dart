import 'package:flutter/material.dart';
import 'package:home_well/Model/AdminModel/adminProfileModel.dart';

import 'a_profile.dart';

AdminDataFromFireStore updateDataFromFireStore = new AdminDataFromFireStore();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _name = new TextEditingController();


class UpdateName extends StatefulWidget {
  final String uid;

  const UpdateName({Key key, this.uid}) : super(key: key);

  @override
  _UpdateNameState createState() => _UpdateNameState(uid);
}


class _UpdateNameState extends State<UpdateName> {
  String uid;

  _UpdateNameState(this.uid);

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
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Profile()));
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
                    )),

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
                              uid, 'Name', _name.text);
                          updateDataFromFireStore.removeValueFromSP('cName');
                          updateDataFromFireStore.save('cName', _name.text);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => Profile()));
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
