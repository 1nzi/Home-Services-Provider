import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Saad/fyp/lib/Model/CustomerModel/customerProfileModel.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomerCtrl.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'c_available_worker.dart';

class CustomerLocationSelection extends StatefulWidget {


  State<StatefulWidget> createState() {
    return LocationSelection();
  }
}
TextEditingController _StreetAdd = new TextEditingController();
var _myKey = GlobalKey<FormState>();
 SharedPreferences sp;

class LocationSelection extends State<CustomerLocationSelection> {
  String _city;
  String _area;
  void initState() {
    initSp();
    super.initState();

  }

  initSp() {
    customerDataFromFireStore.getSharedPreferences().then((value) {
      setState(() {
        sp = value;
        getLocation();
      });
    });
  }
  getLocation() async {
     _city = sp.getString('city');
     _area = sp.getString('area');
    _StreetAdd.text = sp.getString('address');
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        leading: new IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            sp.remove('date');
            sp.remove('time');
            Navigator.pop(context);
          },
        ),
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
                            value: _city,
                            items: city,
                            onChanged: (String newValue) {
                              setState(() {
                                _city = newValue;
                                //bundle.city = newValue;
                                _area = null;
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
                      .document(_city)
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
                                _area = newValue;
                                sp.setString('area', _area);
                                // bundle.area = newValue;
                              });
                            },
                            value: _area,
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
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  controller: _StreetAdd,
                  decoration: const InputDecoration(
                    labelText: 'Street Address',
                    prefixIcon: Icon(Icons.location_city, color: Colors.lightGreen,),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: clearAddress,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (newVal) {
                    if (newVal.isEmpty) {
                      return 'Street Address is required';
                    }
                    return null;
                  },
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
          if(sp.containsKey('date')&& sp.containsKey('time')){
            if(_myKey.currentState.validate()) {
              print(userData.time);
              print(userData.date);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AvailableWorker()));
          }
          }else{
             Scaffold.of(context).showSnackBar(SnackBar(
               content: Text("Select Date or Time"),
               duration: Duration(seconds: 3),
             ));
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
  final format = DateFormat.yMMMd();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async{
        final date = await showDatePicker (
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        String date1 = date.toString().substring(0,10);
        sp.setString('date', date1);
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
          String time1 = DateTimeField.convert(time).toString().substring(11,16);
          sp.setString('time', time1);
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}
