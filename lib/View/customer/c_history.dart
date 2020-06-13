import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'c_history_details.dart';

class CustomerHistory extends StatelessWidget {
  final String userId;

  const CustomerHistory({Key key, this.userId}) : super(key: key);


  Widget _buildTaskList() {
    return Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('Customer')
                .document(userId)
                .collection('History')
                .getDocuments()
                .asStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading...");
              } else {
                List<Task> history = new List();

                for (int i = 0; i < snapshot.data.documents.length; i++) {
                  history.add(Task(
                    snapshot.data.documents[i].documentID,
                    snapshot.data.documents[i].data['WorkerName'],
                    snapshot.data.documents[i].data['WorkerContact'],
                    snapshot.data.documents[i].data['Job'],
                    snapshot.data.documents[i].data['SubJob'],
                    List.from(snapshot.data.documents[i].data['SubJobField']),
                    snapshot.data.documents[i].data['WorkerImg'],
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
                        return TaskCard(
                            task: history[index]);
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
        leading:IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: new Text("History",
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
  final String workerName;
  final String workerContact;
  final String job;
  final String subJob;
  final List<String> subJobFields;
  final String workerImage;
  final String city;
  final String area;
  final String address;
  final String date;
  final String time;

  Task(this.docId, this.workerName, this.workerContact, this.job, this.subJob, this.subJobFields, this.workerImage, this.city, this.area, this.address, this.date, this.time, );

}

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({ this.task});


  @override
  Widget build(BuildContext context) {
    return Card(

      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => HistoryDetails(task: task)));
          },

          child: Container(
            decoration: BoxDecoration(color: Colors.black12),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading:Container(
                    width: 50.0,
                    height: 100.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(fit: BoxFit.fill, image: NetworkImage( task.workerImage))),
                  ),

                  title: Text(task.workerName,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                  subtitle:
                  Text(task.job),
                  trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Text(task.time), Text(task.date)]),
                )
              ],
            ),

          )
      ),
    );
  }
}
