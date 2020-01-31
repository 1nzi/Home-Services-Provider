import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'c_location_selection.dart';

class SelectSubCategory extends StatefulWidget {
  _MySignupPageState createState() => _MySignupPageState();
}

class _MySignupPageState extends State<SelectSubCategory> {
  // ignore: non_constant_identifier_names
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
          "Select Jobs",
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
              MaterialPageRoute(builder: (context) => CustomerLocationSelection()));
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
