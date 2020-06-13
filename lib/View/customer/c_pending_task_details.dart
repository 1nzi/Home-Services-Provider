import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomerCtrl.dart';
import 'package:home_well/Model/CustomerModel/AddJobRequest.dart';

import 'c_pending_task.dart';
import 'c_rating_bar.dart';

AddJobRequest _jobRequest = new AddJobRequest();
CustomerData _customerData = new CustomerData();

class PendingTaskDetails extends StatefulWidget {
  final Task task;

  const PendingTaskDetails({Key key, this.task}) : super(key: key);

  @override
  _PendingTaskDetailsState createState() => _PendingTaskDetailsState(task);
}

class _PendingTaskDetailsState extends State<PendingTaskDetails> {
  final Task task;

  _PendingTaskDetailsState(this.task);

  @override
  Widget build(BuildContext context) {
    currentUser();
    Color color;
    if (task.jobStatus == 'Accepted')
      color = Colors.lightGreen;
    else
      color = Colors.red;

    return new AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Center(
        child: const Text(
          'Work Detail',
          style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 24.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(task.workerImage)))),
              Text(
                task.workerName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                task.workerContact,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                task.jobStatus,
                style: TextStyle(
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: color),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Type :  " + task.job,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      "Field : " + task.subJob,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      "Sub Fields :  " + task.subJobFields.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      "Address :  " +
                          task.address +
                          ", " +
                          task.area +
                          ", " +
                          task.city,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ]),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Container(
                  child: RaisedButton(
                    color: Colors.lightGreen,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RatingBar(task: task)));
                      await addToHistory(task);
                    },
                    child: Text(
                      "Completed",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
              )),

              Container(
                  child: RaisedButton(
                    color: Colors.lightGreen,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () async {
                      await _jobRequest.removeFromPending(task.docId, user.uid);
                      Navigator.pop(context);

                    },
                    child: Text(
                      "Cancel Request",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )),
            ],
      )),
    );
  }
}
final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseUser user;

currentUser()async{
  user = await _auth.currentUser();
}

addToHistory(Task task) async{
  _customerData.userId = user.uid;
  _customerData.workerName = task.workerName;
  _customerData.workerContact = task.workerContact;
  _customerData.workerImg = task.workerImage;
  _customerData.job = task.job;
  _customerData.subJob = task.subJob;
  _customerData.subJobFields = task.subJobFields;
  _customerData.date = task.date;
  _customerData.time = task.time;
  _customerData.city = task.city;
  _customerData.area = task.area;
  _customerData.address = task.address;


  await _jobRequest.removeFromPending(task.docId, user.uid);
  await _jobRequest.updateCustomerHistory(task.docId, _customerData);


}