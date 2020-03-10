import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:home_well/Controller/CustomerController/customerProfile.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomer.dart';
import 'package:intl/intl.dart';

import 'c_available_worker.dart';

class CustomerLocationSelection extends StatefulWidget {
  final CustomerData user;

  const CustomerLocationSelection({Key key, this.user}) : super(key: key);

  State<StatefulWidget> createState() {
    return LocationSelection(user);
  }
}

final TextEditingController _StreetAdd = new TextEditingController();
var _myKey = GlobalKey<FormState>();

class LocationSelection extends State<CustomerLocationSelection> {
  final CustomerData user;

  LocationSelection(this.user);

  @override
  Widget build(BuildContext context) {
    String City = user.city;
    String Area = user.area;
    _StreetAdd.text = user.address;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(
          "Time & Address",
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _myKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Text('When would you like us to come?',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold)),
              Text('Date',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 18.0,
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(18, 0, 18, 18),
                  child: DateField()),
              Text("Time",
                  style: TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 18.0,
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(18, 0, 18, 18),
                  child: TimeField()),
              SizedBox(
                height: 20,
              ),
              Text("Select City",
                  style: TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 18.0,
                  )),
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("City").snapshots(),
                  builder: (context, snapshot) {
                    List<DropdownMenuItem<String>> city = new List();
                    if (!snapshot.hasData) {
                      return Text("No City Found");
                    } else {
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        city.add(
                          DropdownMenuItem(
                            child: Text(snap.documentID),
                            value: "${snap.documentID}",
                          ),
                        );
                      }
                      return Padding(
                          padding: EdgeInsets.fromLTRB(18, 0, 18, 10),
                          child: DropdownButton<String>(
                            icon: Icon(
                              Icons.location_city,
                              color: Colors.lightGreen,
                              // ignore: missing_return
                              size: 24,
                            ),
                            style:
                                TextStyle(color: Colors.black, fontSize: 18.0),
                            isExpanded: true,
                            value: City,
                            items: city,
                            onChanged: (String newValue) {
                              setState(() {
                                City = newValue;
                                //bundle.city = newValue;
                                Area = null;
                              });
                            },
                          ));
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              Text("Select Area",
                  style: TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 18.0,
                  )),
              StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance
                      .collection("City")
                      .document(City)
                      .get()
                      .asStream(),
                  builder: (context, snapshot) {
                    List<String> area = new List();
                    if (!snapshot.hasData) {
                      return Text("Loading...");
                    } else {
                      area = List.from(snapshot.data['Area']);

                      return Padding(
                          padding: EdgeInsets.fromLTRB(18, 0, 18, 10),
                          child: DropdownButtonFormField<String>(
                            icon: Icon(
                              Icons.location_city,
                              color: Colors.lightGreen,
                              // ignore: missing_return
                              size: 24,
                            ),
                            style:
                                TextStyle(color: Colors.black, fontSize: 18.0),
                            isExpanded: true,
                            hint: new Text("Select Area"),
                            items: area
                                .map<DropdownMenuItem<String>>((String area) {
                              return DropdownMenuItem<String>(
                                value: area,
                                child: Text(area),
                              );
                            }).toList(),
                            onChanged: (String newValue) {
                              setState(() {
                                Area = newValue;
                                // bundle.area = newValue;
                              });
                            },
                            value: Area,
                            validator: (newVal) {
                              if (newVal == null) {
                                return 'Area is required';
                              }
                              return null;
                            },
                          ));
                    }
                  }),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  controller: _StreetAdd,
                  decoration: const InputDecoration(
                    labelText: 'Street Address',
                    prefixIcon: Icon(Icons.location_city),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: clearAddress,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ProceedButton()
            ],
          ),
        ),
      ),
    );
  }
}

class ProceedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 40.0,
      child: RaisedButton(
        elevation: 6.0,
        textColor: Colors.white,
        color: Colors.lightGreen,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
        child: Text(
          "Proceed",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        onPressed: () {
          print(userData.time);
          print(userData.date);
          if (userData.time != null && userData.date != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AvailableWorker(user: userData)));
          }
        }
      ),
    );
  }
}

void clearAddress() {
  _StreetAdd.clear();
}

class DateField extends StatelessWidget {
  final format = DateFormat.yMMMMd();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          final date = showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            userData.date = date;
          }
          return date;
        },
      ),
    ]);
  }
}

class TimeField extends StatelessWidget {
  final format = DateFormat.jm();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          if (time != null) {
            userData.time = DateTimeField.convert(time);
          }
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}
