import 'package:flutter/material.dart';

import 'w_profile.dart';


class WorkerUpdateAddress extends StatefulWidget {
  @override
  _UpdateAddressState createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<WorkerUpdateAddress> {
  var city = ['Lahore', 'Islamabad', 'Multan', 'Karachi'];
  var selectedCity = 'Lahore';

  var area = ['Iqbal Town', 'Johar Town', 'Shad Bagh', 'Mall Road'];
  var selectedArea = 'Johar Town';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Update your address',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 30),
              ),
              Text(
                'City',
                style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.none,
                  color: Colors.grey,
                ),
                // textAlign: TextAlign.start,
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              DropdownButton<String>(
                items: city.map((String dropdownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropdownStringItem,
                    child: Text(dropdownStringItem),
                  );
                }).toList(),
                onChanged: (String newValueSelected) {
                  setState(() {
                    this.selectedCity = newValueSelected;
                  });
                },
                value: selectedCity,
                isExpanded: true,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text(
                'Area',
                style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.none,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              DropdownButton<String>(
                items: area.map((String dropdownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropdownStringItem,
                    child: Text(dropdownStringItem),
                  );
                }).toList(),
                onChanged: (String newValueSelected) {
                  setState(() {
                    this.selectedArea = newValueSelected;
                  });
                },
                value: selectedArea,
                isExpanded: true,
              ),
              Padding(
                padding: EdgeInsets.only(top: 25),
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
                        return WorkerProfile();
                      }));
                    },

                    //  padding: EdgeInsets.only(top: 20),
                  )),
            ],
          ),
        ),
      );
  }
}
