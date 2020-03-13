import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'c_history_details.dart';

class CustomerHistory extends StatefulWidget {
  final String userId;

  const CustomerHistory({Key key, this.userId}) : super(key: key);

  _CustomerHistoryState createState() => _CustomerHistoryState(userId);
}

class _CustomerHistoryState extends State<CustomerHistory> {
  final String userId;

  _CustomerHistoryState(this.userId);

  @override
  Widget build(BuildContext context) {
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
                List<HistoryData> hd = new List();
                for (int i = 0; i < snapshot.data.documents.length; i++) {
                  hd.add(HistoryData(
                    snapshot.data.documents[i].data['WorkerName'],
                    snapshot.data.documents[i].data['Job'],
                    snapshot.data.documents[i].data['WorkerImg'],
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
                        return HistoryCard(
                            historyData: hd[index]);
                      })
                      : Center(child: Text('This Job has No SubJobs')),
                );
              }
            }));
  }
}


class HistoryData {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String date;
  final String time;

  HistoryData(this.title, this.subtitle, this.imageUrl, this.date, this.time);
}

class HistoryCard extends StatelessWidget {
  final HistoryData historyData;

  const HistoryCard({Key key, this.historyData}) : super(key: key);

  @override
  Widget build(BuildContext cxt) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: InkWell(
          onTap: () {
            Navigator.push(
                cxt,
                new MaterialPageRoute(
                    builder: (context) => new HistoryDetails()));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.asset(historyData.imageUrl,
                    height: 150, fit: BoxFit.fill),
              ),
              ListTile(
                title: Text(
                  historyData.title,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}