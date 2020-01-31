import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'c_available_worker.dart';

class CustomerLocationSelection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LocationSelection();
  }
}

final TextEditingController _clearStreetAdd = new TextEditingController();

class LocationSelection extends State<CustomerLocationSelection> {
  // ignore: non_constant_identifier_names
  String City = 'Lahore';

  // ignore: non_constant_identifier_names
  String Area = 'DHA';

  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.fromLTRB(18, 0, 18,18),
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
            Padding(
                padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
                child: DropdownButton<String>(
                  value: City,
                  icon: Icon(
                    Icons.location_city,
                    color: Colors.lightGreen,
                    size: 24,
                  ),
                  isExpanded: true,
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                  onChanged: (String newValue) {
                    setState(() {
                      City = newValue;
                    });
                  },
                  items: <String>[
                    'Lahore',
                    'Krachi',
                    'Multan',
                    'Islamabad',
                    'Faislabad',
                  ].map<DropdownMenuItem<String>>((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                )),
            SizedBox(
              height: 10,
            ),
            Text("Select Area",
                style: TextStyle(
                  color: Colors.lightGreen,
                  fontSize: 18.0,
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
                child: DropdownButton<String>(
                  hint: Text('Select Area'),
                  value: Area,
                  icon: Icon(Icons.location_city,
                      color: Colors.lightGreen, size: 24),
                  isExpanded: true,
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                  onChanged: (String newValue) {
                    setState(() {
                      Area = newValue;
                    });
                  },
                  items: <String>[
                    'DHA',
                    'Samnabad',
                    'Shadman',
                    'Johar Town',
                    'Muslim Town',
                    'Anarkali',
                    'MughalPura'
                  ].map<DropdownMenuItem<String>>((String area) {
                    return DropdownMenuItem<String>(
                      value: area,
                      child: Text(area),
                    );
                  }).toList(),
                )),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.multiline,
                controller: _clearStreetAdd,
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
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AvailableWorker()));
        },
      ),
    );
  }
}

void clearAddress() {
  _clearStreetAdd.clear();
}

class DateField extends StatelessWidget {
  final format = DateFormat.yMMMMd();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
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
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}
