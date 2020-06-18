import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_well/View/Admin/a_login.dart';




class WorkerData extends StatefulWidget {
  final String uid;


  const WorkerData({Key key, this.uid}) : super(key: key);

  _WorkerDataState createState() => _WorkerDataState();
}
final FocusNode _SignupButtonFocus = FocusNode();
final _formKey = GlobalKey<FormState>();
String City = 'Lahore';

String Job='Electrical';
int _radioValue = 0;
String Area ;




class _WorkerDataState extends State<WorkerData> {


  void _handleRadioValueChange(int value) {

    _radioValue = value;
    setState(() {
      switch (_radioValue) {
        case 0:
          print(_radioValue);
          break;
        case 1:
          print(_radioValue);
          break;
        case 2:
          print(_radioValue);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text( " Filter Workers Data",
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        child:Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Select By City ",
                ),
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
                                  Area = null;
                                });
                              },
                            ));
                      }
                    }),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "By Area",
                ),
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

                                });
                              },
                              validator: (newVal) {
                                if (newVal == null) {
                                  return 'Area is required';
                                }
                                return null;
                              },
                              value: Area,
                            ));
                      }
                    }),

                //////////////////////
                SizedBox(
                  height: 10,
                ),
                ////
                Text(
                  "Select By City ",
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection("Jobs").snapshots(),
                    builder: (context, snapshot) {
                      List<DropdownMenuItem<String>> job = new List();
                      if (!snapshot.hasData) {
                        return Text("No Job Found");
                      } else {
                        for (int i = 0; i < snapshot.data.documents.length; i++) {
                          DocumentSnapshot snap = snapshot.data.documents[i];
                          job.add(
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
                              value: Job,
                              items: job,
                              onChanged: (String newValue) {
                                setState(() {
                                  Job = newValue;
                                  Area = null;
                                });
                              },
                            ));
                      }
                    }),


                Row(
                      children: <Widget>[
                        new Radio(
                          value: 0,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        new Text('City'),
                        new Radio(
                          value: 1,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        new Text('Area'),
                        new Radio(
                          value: 2,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        new Text('Job'),
                      ],


                ),


                SizedBox(
                  height: 60,
                ),
                SearchButton()


              ],


            ),
          ),
        ),
      ),
    );
  }
}

class SearchButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.0,
      height: 35.0,
      child: RaisedButton(
        focusNode: _SignupButtonFocus,

        elevation: 6.0,
        textColor: Colors.white,
        color: Colors.lightGreen,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
        child: Text(
          "Search",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        onPressed: () async {
          if (_formKey.currentState.validate()) {

            print("Area : $Area");
            print("Area : $City");
            print("Area : $Job");

            print("Area : $_radioValue");







//              Navigator.pop(context);
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => AdminLogin()));
            }

        },
      ),
    );
  }
}





void _fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

