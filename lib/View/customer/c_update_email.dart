import 'package:flutter/material.dart';
import 'package:home_well/customer/c_profile.dart';

class UpdateEmail extends StatefulWidget {
  @override
  _UpdateEmailState createState() => _UpdateEmailState();
}

class _UpdateEmailState extends State<UpdateEmail> {
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
              Navigator.pop(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Update your email',
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
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your new email address',
                  hintStyle: TextStyle(),
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
        ));
  }
}
