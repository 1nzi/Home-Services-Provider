import 'package:flutter/material.dart';

import '../customer/c_location_selection.dart';
import '../customer/c_sub_category.dart';

class PaintingService extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PaintingService();
  }
}

class _PaintingService extends State<PaintingService> {
  DateTime date1;
  DateTime date2;
  DateTime date3;

  List<String> professional = ['9', '3', '4'];
  List<String> hours = ['1', '2', '3', '4', '5'];
  List<String> ladder = ['No', 'Yes'];

  String _professional;
  String _ladder;
  String _hours;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Interior Panting Service',
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Tell us about the job",
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Number of professionals?",
              style: TextStyle(fontSize: 15.0, color: Colors.lightGreen),
            ),
          ),
          DropdownButton(
            // Not necessary for Option 1
            value: _professional,
            hint: Text("Choose"),

            onChanged: (newValue) {
              setState(() {
                _professional = newValue;
              });
            },

            items: professional.map((location) {
              return DropdownMenuItem(
                child: new Text(location),
                value: location,
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Will a Ladder be Required?",
              style: TextStyle(fontSize: 15.0, color: Colors.lightGreen),
            ),
          ),
          DropdownButton(
            // Not necessary for Option 1
            value: _ladder,
            hint: Text("Choose optoin"),

            onChanged: (newValue) {
              setState(() {
                _ladder = newValue;
              });
            },
            items: ladder.map((location) {
              return DropdownMenuItem(
                child: new Text(location),
                value: location,
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Description:",
              style: TextStyle(fontSize: 17.0, color: Colors.lightGreen),
            ),
          ),
          SizedBox(height: 4),
          TextFormField(
            decoration: new InputDecoration(
              hintText: "  Please describe the Job in Detail.",
              alignLabelWithHint: true,
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightGreen,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightGreen),
              ),
            ),
            maxLines: 5,
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (term) {},
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "How many Hours would You like to Book?",
              style: TextStyle(fontSize: 15.0, color: Colors.lightGreen),
            ),
          ),
          DropdownButton(
            // Not necessary for Option 1
            value: _hours,
            hint: Text("Choose Hours"),

            onChanged: (newValue) {
              setState(() {
                _hours = newValue;
              });
            },
            items: hours.map((location) {
              return DropdownMenuItem(
                child: new Text(location),
                value: location,
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Container(
                  width: 130,
                  child: RaisedButton(
                    color: Colors.lightGreen,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SubJobs()));
                    },
                    child: Text(
                      "Add more jobs",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  )),
              SizedBox(
                width: 7,
              ),
              Container(
                  width: 130,
                  child: RaisedButton(
                    color: Colors.lightGreen,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CustomerLocationSelection()));
                    },
                    child: Text(
                      "Proceed",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
