import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_well/worker/w_complete_task.dart';

class MyNotificationDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyNotificationDetailsState();
}

class _MyNotificationDetailsState extends State<MyNotificationDetails> {
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Work Details",
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: media.width * 0.85,
            height: media.height * 0.70,
            color: Colors.black12,
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  width: media.width * 0.40,
                  child: RaisedButton(
                    color: Colors.lightGreen,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )),
              Container(
                  width: media.width * 0.40,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: Colors.lightGreen,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyJobStatus()));
                    },
                    child: Text(
                      "Accept",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
