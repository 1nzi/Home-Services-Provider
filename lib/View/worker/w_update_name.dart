import 'package:flutter/material.dart';

import '../common/main.dart';
import 'w_profile.dart';

class WorkerUpdateName extends StatefulWidget {
  @override
  _UpdateNameState createState() => _UpdateNameState();
}

class _UpdateNameState extends State<WorkerUpdateName> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            //title: Text('Update Your Name'),
            backgroundColor: Colors.lightGreen,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context, MaterialPageRoute(builder: (context) {
                    return WorkerProfile();
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
                TextFormField(
                  maxLength: 17,
                  validator: (String value){
                    if(value.isEmpty){
                      return "Please enter a valid name first";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your full name',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
              Container(
                width: 330,
                  child:RaisedButton(
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
                            return MyApp();
                          }));
                    },

                    //  padding: EdgeInsets.only(top: 20),
                  )
              ),
              ],
            ),
          )
    );
  }
}
