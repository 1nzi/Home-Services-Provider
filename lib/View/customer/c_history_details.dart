import 'package:flutter/material.dart';

import 'c_history.dart';


class HistoryDetails extends StatefulWidget {
  final Task task;

  const HistoryDetails({Key key, this.task}) : super(key: key);

  @override
  _HistoryDetailsState createState() => _HistoryDetailsState(task);
}

class _HistoryDetailsState extends State<HistoryDetails> {
  final Task task;

  _HistoryDetailsState(this.task);

  @override
  Widget build(BuildContext context) {
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
            ],
          )),
    );
  }
}