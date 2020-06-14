import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';
import 'package:home_well/View/worker/w_pending_task_details.dart';

class WorkerPendingTask extends StatelessWidget {


final String userId;


   WorkerPendingTask({Key key, this.userId}) : super(key: key);


  Widget _buildTaskList() {

    return Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('Worker')
                .document(userId)
                .collection('JobRequest')
                .getDocuments()
                .asStream(),
            
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading...");
              } else {

                List<Task> pendingTask = new List();
                print(snapshot.data.documents.length);
                for(int i = 0; i < snapshot.data.documents.length; i++) {


                  pendingTask.add(Task(
                    snapshot.data.documents[i].documentID,
                    snapshot.data.documents[i].data['CustomerName'],
                    snapshot.data.documents[i].data['CustomerId'],
                    snapshot.data.documents[i].data['CustomerContact'],
                    snapshot.data.documents[i].data['Job'],
                    snapshot.data.documents[i].data['JobStatus'],
                    snapshot.data.documents[i].data['SubJob'],
                    List.from(snapshot.data.documents[i].data['SubJobField']),
                    snapshot.data.documents[i].data['CustomerImg'],
                    snapshot.data.documents[i].data['City'],
                    snapshot.data.documents[i].data['Area'],
                    snapshot.data.documents[i].data['Address'],
                    snapshot.data.documents[i].data['Date'],
                    snapshot.data.documents[i].data['Time'],
                  ));
                }
                return Container(
                  child: snapshot.data.documents.length > 0
                      ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TaskCard(task: pendingTask[index]);
                      })
                      : Center(child: Text('This Job has No SubJobs')),
                );
              }
            }));
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: new AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }),
      title: new Text(
        "Pending Task",
        style: new TextStyle(
            fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    ),
    body: _buildTaskList(),
  );
}
}

class Task {

  final String docId;
  final String customerName;
  final String customerId;
  final String customerContact;
  final String job;
  final String jobStatus;
  final String subJob;
  final List<String> subJobFields;
  final String workerImage;
  final String city;
  final String area;
  final String address;
  final String date;
  final String time;

  Task(
      this.docId,
      this.customerName,
      this.customerId,
      this.customerContact,
      this.job,
      this.jobStatus,
      this.subJob,
      this.subJobFields,
      this.workerImage,
      this.city,
      this.area,
      this.address,
      this.date,
      this.time,
      );
}

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({this.task});

  @override
  Widget build(BuildContext context) {
    Color color;
    if (task.jobStatus == 'Accepted')
      color = Colors.lightGreen;
    else
      color = Colors.red;

    return Card(
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => PendingTaskDetails (task: task)));
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.black12),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Container(
                    width: 50.0,
                    height: 100.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(task.workerImage??
                                "https://previews.123rf.com/images/tuktukdesign/tuktukdesign1606/tuktukdesign160600105/59070189-user-icon-man-profile-businessman-avatar-person-icon-in-vector-illustration.jpg"
                        ))),
                  ),
                  title: Text(
                    task.customerName,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [Text(task.job), Text(task.date)]),
                  trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          task.jobStatus,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: color),
                        ),
                        Text(task.time),
                      ]),
                )
              ],
            ),
          )),
    );
  }
}
