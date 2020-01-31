import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count = 0;
  int count1 = 0;

  var ladder = ['No', 'Yes - 6ft(1.8m)', 'Yes - 10ft(3.0m)'];
  var selectedLadder = 'No';
  var fixture = ['No', 'Yes'];
  var selectedFixture = 'No';

  var hours = [
    '2 hours',
    '3 hours',
    '4 hours',
    '5 hours',
  ];
  var selectedHours = '2 hours';

//  var time = [
//    '8 AM',
//    '9 AM',
//    '10 AM',
//    '11 AM',
//    '12 PM',
//    '1 PM',
//    '2 PM',
//    '3 PM',
//    '4 PM',
//    '5 PM',
//  ];
//  var selectedTime = '8 AM';
//
  void _incrementCounter() {
    setState(() {
      count++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (count > 0) count--;
    });
  }

  void _addCounter() {
    setState(() {
      count1++;
    });
  }

  void _removeCounter() {
    setState(() {
      if (count1 > 0) count1--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                'Light Fixture Installation',
              ),
              backgroundColor: Colors.lightGreen,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Tell us about the job',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                              onPressed: _decrementCounter,
                              child: Icon(Icons.remove)),
                        ),
                        Expanded(
                          child: Text(
                            '$count change bulbs',
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                              onPressed: _incrementCounter,
                              child: Icon(Icons.add)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            onPressed: _removeCounter,
                            child: Icon(Icons.remove),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '$count1 install new light',
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                              onPressed: _addCounter, child: Icon(Icons.add)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                    ),
                    Text(
                      'Will a ladder be required?',
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    DropdownButton<String>(
                      items: ladder.map((String dropdownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropdownStringItem,
                          child: Text(dropdownStringItem),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        setState(() {
                          this.selectedLadder = newValueSelected;
                        });
                      },
                      value: selectedLadder,
                      isExpanded: true,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(
                      'Do you need us to provide the fixture?',
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    DropdownButton<String>(
                      items: fixture.map((String dropdownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropdownStringItem,
                          child: Text(dropdownStringItem),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        setState(() {
                          this.selectedFixture = newValueSelected;
                        });
                      },
                      value: selectedFixture,
                      isExpanded: true,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Container(
                      height: 200,
                      width: 330,
                      child: Stack(
                        children: <Widget>[
                          TextField(
                            maxLines: 10,
                            decoration: InputDecoration(
                                hintText:
                                    "Please Describe the job in detail.(Optional)",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(
                      'We recommended 2 hours',
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    DropdownButton<String>(
                      items: hours.map((String dropdownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropdownStringItem,
                          child: Text(dropdownStringItem),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        setState(() {
                          this.selectedHours = newValueSelected;
                        });
                      },
                      value: selectedHours,
                      isExpanded: true,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(
                      'When would you like us to come?',
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text('Date',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        )),
                    DateField(),
                    Padding(
                      padding: EdgeInsets.all(2.0),
                    ),
                    Text("Time",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        )),
                    TimeField(),
                    Padding(
                      padding: EdgeInsets.all(15),
                    ),
                    Container(
                        width: 330,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.lightGreen)),
                          color: Colors.lightGreen,
                          onPressed: () {},
                          child: Text(
                            "Get a Price",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        )),
                  ]),
            )));
  }
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
