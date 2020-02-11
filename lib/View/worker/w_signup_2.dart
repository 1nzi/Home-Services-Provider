import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_well/Controller/WorkerController/rigesterWorker.dart';
import 'package:home_well/View/customer/c_signup_2.dart';
import 'w_signup_1.dart';
import 'w_signup_3.dart';

class WorkerSignup2 extends StatefulWidget {
  final WorkerData bucket;

  const WorkerSignup2({Key key, this.bucket}) : super(key: key);

  _MySignupPageState createState() => _MySignupPageState();
}

final _formKey = GlobalKey<FormState>();

class _MySignupPageState extends State<WorkerSignup2> {
  // ignore: non_constant_identifier_names
  String City = 'Lahore';
  // ignore: non_constant_identifier_names
  String Area;
  // ignore: non_constant_identifier_names
  String Job ;
  bool subJobState = false;
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(
          "Signup Page 2",
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "Select City",
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
                                bucket.city = newValue;
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
                "Select Area",
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
                                bucket.area = newValue;
                              });
                            },
                            validator: (newVal) {
                              if (newVal==null) {
                                return 'Area is required';
                              }
                              return null;
                            },
                            value: Area,
                          ));
                    }
                  }),
              Divider(
                color: Colors.black12,
                height: 20,
              ),
              Text(
                "Select Job",
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("Jobs").snapshots(),
                  builder: (context, snapshot) {
                    List<DropdownMenuItem<String>> job = new List();
                    if (!snapshot.hasData) {
                      return Text("Loading...");
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
                          child: DropdownButtonFormField<String>(
                            icon: Icon(
                              Icons.school,
                              color: Colors.lightGreen,
                              // ignore: missing_return
                              size: 24,
                            ),
                            style:
                                TextStyle(color: Colors.black, fontSize: 18.0),
                            isExpanded: true,
                            hint: Text("Select Job"),
                            items: job,
                            onChanged: (String newValue) {
                              setState(() {
                                Job = newValue;
                                bucket.job = newValue;
                                subJobState = true;
                              });
                            },
                            value: Job,
                            validator: (newVal) {
                              if (newVal?.isEmpty ?? true) {
                                return 'Job is required';
                              }
                              return null;
                            },
                          ));
                    }
                  }),
          Visibility(
            visible: subJobState,
            child:Text("Select Sub Jobs")
          ),

          Visibility(
            visible: subJobState,
            child:StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance
                      .collection("Jobs")
                      .document(Job)
                      .get()
                      .asStream(),
                  builder: (context, snapshot) {
                    List<String> subJob = new List();
                    List<SubJobs> subJobs = new List();
                    if (!snapshot.hasData) {
                      return Text("Loading...");
                    } else {
                      subJob = List.from(snapshot.data['SubJobs']);
                      for (int i = 0; i < subJob.length; i++) {
                        subJobs.add(SubJobs(subJob[i], false));
                      }
                      return Container(
                        height: 200,
                        width: media.width * 0.85,
                        color: Colors.lightGreen,
                        child: Container(
                          child: subJobs.length > 0
                              ? ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: subJobs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SubJobsCard(subJobs: subJobs[index]);
                                  })
                              : Center(child: Text('This Job has No SubJobs')),
                        ),
                      );
                    }
                  }),
          ),
              SizedBox(
                height: 20,
              ),
              NextButton()
            ],
          ),
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
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

          print(bucket.city);
          print(bucket.area);
          print(bucket.subJobs);

          if (bucket.city == null) {
            bucket.city = 'Lahore';
          }

          if (_formKey.currentState.validate()){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WorkerSignup3(bucket: bucket)));
          }
        },
      ),
    );
  }
}

class SubJobs {
  final String title;
  bool isCheck;

  SubJobs(this.title, this.isCheck);
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
              ListTile(
                title: Text(
                  subJobs.title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                trailing: Checkbox(
                    value: subJobs.isCheck,
                    onChanged: (bool value) {

                      setState(() {
                        subJobs.isCheck = value;

                      });
                    }),
              )
            ],
          ),
        ));
  }
}
