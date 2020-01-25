import 'package:flutter/material.dart';
import 'package:home_well/customer/c_profile.dart';

class Gender extends StatefulWidget {
  @override
  _GenderState createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  int selectedRadioTile;

  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Gender',
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
            padding: EdgeInsets.all(15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Gender',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        //                  fontFamily: 'Raleway',
                      )),
                  RadioListTile(
                    value: 1,
                    groupValue: selectedRadioTile,
                    title: Text('Male'),
                    onChanged: (val) {
                      setSelectedRadioTile(val);
                    },
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: selectedRadioTile,
                    title: Text('Female'),
                    onChanged: (val) {
                      setSelectedRadioTile(val);
                    },
                  ),
                  RadioListTile(
                    value: 3,
                    groupValue: selectedRadioTile,
                    title: Text('Prefer not to specify'),
                    onChanged: (val) {
                      setSelectedRadioTile(val);
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.lightGreen)),
                          color: Colors.lightGreen,
                          child: Text(
                            'Cancel',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pop(context,
                                MaterialPageRoute(builder: (context) {
                              return Profile();
                            }));
                          },
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.lightGreen)),
                          color: Colors.lightGreen,
                          child: Text(
                            'Ok',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pop(context,
                                MaterialPageRoute(builder: (context) {
                              return Profile();
                            }));
                          },
                        ),
                      )
                    ],
                  ),
                ]
            )
        )
    );
  }
}
