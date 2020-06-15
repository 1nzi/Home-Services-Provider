import 'package:flutter/material.dart';
import 'package:home_well/Model/WorkerModel/WorkerProfileModel.dart';

import 'w_profile.dart';


WorkerDataFromFireStore  updateDataFromFireStore = new WorkerDataFromFireStore ();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _name = new TextEditingController();

class WUpdateName extends StatefulWidget {
  final String uid;

  const WUpdateName({Key key, this.uid}) : super(key: key);

  @override
  _WUpdateNameState createState() => _WUpdateNameState(uid);
}

class _WUpdateNameState extends State<WUpdateName> {
  String uid;

  _WUpdateNameState(this.uid);
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
                    MaterialPageRoute(builder: (context) => WProfile()));
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
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          print("iddddddddddddd :$uid");
                          updateDataFromFireStore.updateData(
                              uid, 'Name', _name.text);
                          updateDataFromFireStore.removeValueFromSP('wName');
                          updateDataFromFireStore.save('wName', _name.text);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => WProfile()));
                        }
                      }, //  padding: EdgeInsets.only(top: 20),
                    )),
              ],
            ),
          ),
        ));
  }
}
