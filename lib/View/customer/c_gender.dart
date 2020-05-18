import 'package:flutter/material.dart';
import 'file:///C:/Users/Saad/fyp/lib/Model/CustomerModel/customerProfileModel.dart';

import 'c_profile.dart';

CustomerDataFromFireStore updateDataFromFireStore = new CustomerDataFromFireStore();

class Gender extends StatefulWidget {
  final String uid;

  const Gender({Key key, this.uid}) : super(key: key);

  @override
  _GenderState createState() => _GenderState(uid);
}

class _GenderState extends State<Gender> {
  final String uid;

  int selectedRadioTile;

  _GenderState(this.uid);

  @override
  void initState() {
    super.initState();
    selectedRadioTile = 1;
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
                  SizedBox(height: 20,),
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
                      SizedBox(width: 10,),
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
                            if(selectedRadioTile==1){
                              updateDataFromFireStore.updateData(
                                  uid, 'Gender', 'Male');
                              updateDataFromFireStore.removeValueFromSP('gender');
                              updateDataFromFireStore.save('gender', 'Male');
                            }
                            else{
                              updateDataFromFireStore.updateData(
                                  uid, 'Gender', 'Female');
                              updateDataFromFireStore.removeValueFromSP('gender');
                              updateDataFromFireStore.save('gender', 'Female');

                            }
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
