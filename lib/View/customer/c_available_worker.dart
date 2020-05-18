import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'file:///C:/Users/Saad/fyp/lib/Model/CustomerModel/AddJobRequest.dart';
import 'c_wait_for_response.dart';
import 'file:///C:/Users/Saad/fyp/lib/Model/CustomerModel/customerProfileModel.dart';


AddJobRequest _jobRequest = new AddJobRequest();
SharedPreferences sp;

class AvailableWorker extends StatefulWidget {
  //final CustomerData user;

  //const AvailableWorker({Key key, this.user}) : super(key: key);

  _MyWorkerPageState createState() => _MyWorkerPageState();
}

CustomerDataFromFireStore customerDataFromFireStore =
    new CustomerDataFromFireStore();

class _MyWorkerPageState extends State<AvailableWorker> {
//  final CustomerData user;

  _MyWorkerPageState();
  String _city;
  String _area;
  String _job;
  String _subJob;
  List<String> _subJobs;

  @override
  void initState() {
    initSp();
    super.initState();

  }

  initSp() {
    customerDataFromFireStore.getSharedPreferences().then((value) {
      setState(() {
        sp = value;
        getInfo();
      });
    });
  }
  getInfo() async {
    _city = sp.getString('city');
    _area = sp.getString('area');
    _job = sp.getString('job');
    _subJob = sp.getString('subJob');
    _subJobs = sp.getStringList('subJobs');
    print('$_city, $_area, $_job, $_subJob, \n ${_subJobs}');
  }
  Widget _buildWorkerList() {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("Worker")
              .where("City", isEqualTo: _city)
              .where("Area", isEqualTo: _area)
              .where("Job", isEqualTo: _job)
              .where("SubJobs", arrayContains: _subJob)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              print(snapshot.data);
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
          "Available Worker",
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
                trailing: RequestButton(worker: worker),
              )
            ],
          ),
        ));
  }
}

class RequestButton extends StatelessWidget {
  final Worker worker;

  const RequestButton({Key key, this.worker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      height: 30.0,
      child: RaisedButton(
        elevation: 1.0,
        textColor: Colors.black,
        color: Colors.lightGreen,
        child: Text(
          "Request",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 9.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          sp.setString('workerId', worker.workerId);
          sp.setString('workerName', worker.workerName);
          sp.setString('workerImg', worker.imageUrl);
          sp.setString('workerContact', worker.workerContact);
          updateCustomerData(sp);
          print(sp.getInt('jobCount'));

          customerDataFromFireStore.updateJobCount(sp.getString('userId'), 'JobCount' , sp.getInt('jobCount'));

          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ResponseWait()));
         },
      ),
    );
  }
}

final CollectionReference customerCollection = Firestore.instance.collection('Customer');

  Future<void> updateCustomerData(SharedPreferences sp) async {
    customerDataFromFireStore.getSharedPreferences().then((value) {
      sp = value;
    });
    return await customerCollection
        .document(sp.getString('userId'))
        .collection('JobRequest')
        .document('job'+ sp.getInt('jobCount').toString())
        .setData({
      'WorkerId': sp.getString('workerId'),
      'WorkerName': sp.getString('workerName'),
      'WorkerContact': sp.getString('workerContact'),
      'WorkerImg': sp.getString('workerImg'),
      'Job': sp.getString('job'),
      'JobStatus': 'Pending',
      'SubJob': sp.getString('subJob'),
      'SubJobField': FieldValue.arrayUnion(sp.getStringList('subJobFields')),
      'SubJobFieldCount': FieldValue.arrayUnion(sp.getStringList('subJobsCounter')),
      'SubJobFieldPrice': FieldValue.arrayUnion(sp.getStringList('subJobsPrice')),
      'Date': sp.getString('date'),
      'Time': sp.getString('time'),
      'City': sp.getString('city'),
      'Area': sp.getString('area'),
      'Address': sp.getString('address'),
    });
  }
