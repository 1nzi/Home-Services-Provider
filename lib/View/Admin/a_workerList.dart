import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';


SharedPreferences sp;

class TopWorker extends StatefulWidget {
final  String city;
final  String area;
final  String job;

  const TopWorker({Key key, this.city, this.area, this.job}) : super(key: key);


  _MyWorkerPageState createState() => _MyWorkerPageState();
}


class _MyWorkerPageState extends State<TopWorker> {


  @override
  void initState() {
    initSp();
    super.initState();

  }

  initSp() {
  }


  Widget _buildWorkerList() {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("Worker")
              .where("City", isEqualTo: widget.city)
              .where("Area", isEqualTo: widget.area)
              .where("Job", isEqualTo: widget.job)
              .orderBy('Rating', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading...");
            } else {
              print(snapshot.data);
              final doc = snapshot.data.documents;
              List<Worker> worker = new List();
              int workerCount = snapshot.data.documents.length;
              for (var msg in doc) {
                worker.add(Worker(
                  msg.data['Id'],
                  msg.data['Name'],
                  msg.data['Phone'],
                  msg.data['Rating'].toDouble(),
                  msg.data['Image'],
                ));
              }
              return Container(
                child: workerCount > 0
                    ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: workerCount,
                    itemBuilder: (BuildContext context, int index) {
                      return WorkerCard(worker: worker[index]);
                    })
                    : Center(child: Text('No Related Worker Avalible yet')),
              );
            }
          }),
    );
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
          "TopRated Worker",
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: _buildWorkerList(),
    );
  }
}

class Worker {
  final String workerId;
  final String workerName;
  final String workerContact;
  final double rating;
  final String imageUrl;

  Worker(
      this.workerId,
      this.workerName,
      this.workerContact,
      this.rating,
      this.imageUrl,
      );
}

class WorkerCard extends StatelessWidget {
  final Worker worker;

  const WorkerCard({this.worker});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black12),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Container(
                  width: 60.0,
                  height: 100.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(worker.imageUrl != null
                          ? worker.imageUrl
                          : "https://previews.123rf.com/images/tuktukdesign/tuktukdesign1606/tuktukdesign160600105/59070189-user-icon-man-profile-businessman-avatar-person-icon-in-vector-illustration.jpg"),
                    ),
                  ),
                ),
                title: Text(
                  worker.workerName,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Row(children: <Widget>[
                  Text(worker.rating.toString(),
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  Icon(
                    Icons.star,
                    size: 15,
                  )
                ]),
              )
            ],
          ),
        ));
  }
}

