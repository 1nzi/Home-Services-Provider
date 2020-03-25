import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomerCtrl.dart';

import 'c_location_selection.dart';

class SelectSubCategory extends StatefulWidget {
  final CustomerData user;

  const SelectSubCategory({Key key, this.user}) : super(key: key);

  _MySignupPageState createState() => _MySignupPageState(user);
}

List _selectedSubJobs = new List();
StreamController _event =StreamController<int>.broadcast();

class _MySignupPageState extends State<SelectSubCategory> {
  final CustomerData user;

  _MySignupPageState(this.user);

  @override
  void initState() {
    super.initState();
    _event.add(0);
  }

  Widget _buildSubJobsList() {
    Size media = MediaQuery.of(context).size;
    return Container(
        height: media.height * 0.7,
        child: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection("SubJob")
                .document(user.subJob)
                .get()
                .asStream(),
            builder: (context, snapshot) {
              List<String> jobTitle = new List();
              List<String> jobRate = new List();
              List<SubJobs> subCategory = new List();

              if (!snapshot.hasData) {
                return Text("Loading...");
              } else {
                jobTitle = List.from(snapshot.data['Subcategory']);
                jobRate = List.from(snapshot.data['jobRate']);
                for (int i = 0; i < jobTitle.length; i++) {
                  subCategory.add(SubJobs(jobTitle[i], jobRate[i], false));
                }
                return Container(
                  child: subCategory.length > 0
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: subCategory.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SubJobsCard(subJobs: subCategory[index]);
                          })
                      : Center(child: Text('No Items')),
                );
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(
          "Select Jobs",
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _selectedSubJobs = new List();
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              "Select Sub Jobs",
            ),
            _buildSubJobsList(),
            SizedBox(
              height: 20,
            ),
            NextButton(user: user)
          ],
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final CustomerData user;

  const NextButton({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 40.0,
      child: RaisedButton(
          elevation: 5.0,
          textColor: Colors.white,
          color: Colors.lightGreen,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          child: Text(
            "Next",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            user.subJobFields = _selectedSubJobs;
            print(user.subJobFields);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CustomerLocationSelection(user: user)));
          }),
    );
  }
}

class SubJobs {
  final String title;
  final String subtitle;
  bool isCheck;

  SubJobs(this.title, this.subtitle, this.isCheck);
}

class SubJobsCard extends StatefulWidget {
  final SubJobs subJobs;

  const SubJobsCard({this.subJobs});

  @override
  _subJobsCard createState() => _subJobsCard(subJobs: this.subJobs);
}

// ignore: camel_case_types
class _subJobsCard extends State<SubJobsCard> {
  final SubJobs subJobs;

  _subJobsCard({this.subJobs});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 7.0,
        margin: new EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black12),
          child: Column(
            children: <Widget>[
              CheckboxListTile(
                title: Text(
                  subJobs.title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Row(children: <Widget>[
                  Text(
                    subJobs.subtitle,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                        icon: Icon(Icons.remove),
                        //onPressed: _decrementCounter,
                        iconSize: 18,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      child: Center(
                        child: StreamBuilder<int>(
                            stream: _event.stream,
                            builder: (context, snapshot) {
                              return Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add),
                    //  onPressed: _incrementCounter,
                      iconSize: 18,
                    ),
                  ),
                ]),
                value: subJobs.isCheck,
                onChanged: (bool value) {
                  setState(() {
                    subJobs.isCheck = value;
                  });
                  _onSubJobSelected(value, subJobs.title);
                },
              )
            ],
          ),
        ));
  }

  void _onSubJobSelected(bool selected, String subJob) {
    if (selected == true) {
      setState(() {
        _selectedSubJobs.add(subJob);
      });
    } else {
      setState(() {
        _selectedSubJobs.remove(subJob);
      });
    }
  }
}
