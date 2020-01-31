import 'package:flutter/material.dart';

import 'c_profile.dart';

class UpdateName extends StatefulWidget {
  @override
  _UpdateNameState createState() => _UpdateNameState();
}

class _UpdateNameState extends State<UpdateName> {
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
                  return Profile();
                }));
              }),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
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
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your full name',
                ),
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
                      Navigator.pop(context,
                          MaterialPageRoute(builder: (context) {
                        return Profile();
                      }));
                    },

                    //  padding: EdgeInsets.only(top: 20),
                  )),
            ],
          ),
        )
    );
  }
}
