import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomerCtrl.dart';
import 'file:///C:/Users/Saad/fyp/lib/Model/CustomerModel/AddJobRequest.dart';

AddJobRequest _jobRequest = new AddJobRequest();

class ResponseWait extends StatelessWidget {
  final CustomerData user;

  const ResponseWait({Key key, this.user}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                var count = 0;
                Navigator.popUntil(context, (route) {
                  return count++ == 5;
                });
              }),
          title: Text(
            'Wait for Response',
            style: new TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Your request for the ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 7),
              ),
              Text(user.job,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                    color: Colors.lightGreen,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text(
                'is Sent to the Worker',
                style: TextStyle(
                  fontSize: 15,
                  decoration: TextDecoration.none,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text(
                user.workerName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                  color: Colors.lightGreen,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text(
                'You will recieve notification at the Acception of your Request',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  decoration: TextDecoration.none,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 70,),
              RaisedButton(
                color: Colors.lightGreen,
                child: Text(
                  'Cancel Request',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {

                  final FirebaseAuth _auth = FirebaseAuth.instance;
                  FirebaseUser fuser;
                  fuser = await _auth.currentUser();
                  int docId = user.jobCount-1;
                  await _jobRequest.removeFromPending('job' + docId.toString(), fuser.uid);

                  //clear data for next worker request
                  user.workerId = null;
                  user.workerName = null;
                  user.workerImg = null;
                  user.job = null;
                  user.workerContact = null;
                  user.subJob = null;
                  user.time = null;
                  user.date = null;
                  user.subJobFields = null;

                  var count = 0;
                  Navigator.popUntil(context, (route) {
                    return count++ == 5;
                  });
                }

    //  padding: EdgeInsets.only(top: 20),
              )
            ],
          ),
        ));
  }
}
