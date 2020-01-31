import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyJobStatus extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => JobStatus();
}

class JobStatus extends State<MyJobStatus> {
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Work Details",
            style: new TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
        ),
        body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: media.width * 0.85,
                height: media.height * 0.65,
                color: Colors.black12,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: media.width * 0.70,
                  child: RaisedButton(
                    color: Colors.lightGreen,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Mark As Completed",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )),
              Container(
                  width: media.width * 0.70,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: Colors.lightGreen,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyJobStatus()));
                    },
                    child: Text(
                      "Contact Customer",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ))
            ],
          ),
        ));
  }
}
