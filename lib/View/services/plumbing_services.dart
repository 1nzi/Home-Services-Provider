import 'package:flutter/material.dart';

import '../customer/c_location_selection.dart';
import '../customer/c_sub_category.dart';


class PlumbingServices extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PlumbingServicesState();
}

class _PlumbingServicesState extends State<PlumbingServices> {
  // ignore: non_constant_identifier_names
  String Values = '1 hour';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Plumbing Services"),
          backgroundColor: Colors.lightGreen,
        ),
        body: ListView(
          padding: EdgeInsets.all(24),
          children: <Widget>[
            Text('Tell us about the job',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
            Container(
              height: 180,
              width: 220,
              child: Stack(
                children: <Widget>[
                  TextField(
                    maxLines: 8,
                    decoration: InputDecoration(
                        hintText:
                        "Please Describe the job in detail.(Required)",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            Text('How many hours would you like to book?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold)),
            new DropdownButton<String>(
              hint: Text('Select the number of hours'),
              value: Values,
              icon: Icon(Icons.access_time, color:Colors.lightGreen, size:24),
              style: TextStyle(color: Colors.black, fontSize: 18.0),
              onChanged: (String newValue) {
                setState(() {
                  Values = newValue;
                });
              },
              items: <String>['1 hour', '2 hours', '3 hours', '4 hours']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            SizedBox(height: 20,),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>SubJobs()));
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
                                builder: (context) => CustomerLocationSelection()));
                      },
                      child: Text(
                        "Proceed",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ))
              ],
            ),
          ],
        ));
  }
}
