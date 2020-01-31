import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'w_signup_1.dart';
import 'w_signup_3.dart';

class WorkerSignup2 extends StatefulWidget {
  _MySignupPageState createState() => _MySignupPageState();
}

class _MySignupPageState extends State<WorkerSignup2> {
  // ignore: non_constant_identifier_names
  String City = 'Lahore';

  // ignore: non_constant_identifier_names
  String Area = 'DHA';

  // ignore: non_constant_identifier_names
  String Job = 'Electrician';
  final List<SubJobs> subjobs = ElectricianList.getSubJob();

  Widget _buildSubJobsList() {
    return Container(
      child: subjobs.length > 0
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: subjobs.length,
              itemBuilder: (BuildContext context, int index) {
                return SubJobsCard(subJobs: subjobs[index]);
              })
          : Center(child: Text('No Items')),
    );
  }

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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WorkerSignup1();
              }));
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
              "Select City",
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(18, 0, 18, 10),
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
            Text(
              "Select Area",
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(18, 0, 18, 10),
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
            Divider(
              color: Colors.black12,
              height: 20,
            ),
            Text(
              "Select Job",
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(18, 0, 18, 20),
                child: DropdownButton<String>(
                  hint: Text('Select Job'),
                  value: Job,
                  icon: Icon(
                    Icons.school,
                    color: Colors.lightGreen,
                    size: 24,
                  ),
                  isExpanded: true,
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                  onChanged: (String newValue) {
                    setState(() {
                      Job = newValue;
                    });
                  },
                  items: <String>[
                    'Electrician',
                    'Plumber',
                    'Mechanic',
                    'Painter',
                    'Maid',
                    'Carpainter',
                  ].map<DropdownMenuItem<String>>((String job) {
                    return DropdownMenuItem<String>(
                      value: job,
                      child: Text(job),
                    );
                  }).toList(),
                )),
            Text(
              "Select Sub Jobs",
            ),
            Container(
              height: 200,
              width: media.width * 0.85,
              color: Colors.lightGreen,
              child: _buildSubJobsList(),
            ),
            SizedBox(
              height: 20,
            ),
            NextButton()
          ],
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
          Navigator.of(context).pop();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => WorkerSignup3()));
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

class ElectricianList {
  static List<SubJobs> getSubJob() {
    return [
      SubJobs('AC Tech', false),
      SubJobs('Fridge Tech', false),
      SubJobs('TV Tech', false),
      SubJobs('Mobile Tech', false),
      SubJobs('Comp/Laptop Tech', false),
      SubJobs('Bulb/fan/Motor Tech', false),
    ];
  }
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
