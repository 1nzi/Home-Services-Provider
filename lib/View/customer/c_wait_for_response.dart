import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'c_request_accepted.dart';

class ResponseWait extends StatelessWidget {
  final String job;
  final String worker;

  const ResponseWait({Key key, this.job, this.worker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
              Text(job,
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
                worker,
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
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AcceptedRequest()));
                },
                //  padding: EdgeInsets.only(top: 20),
              )
            ],
          ),
        ));
  }
}
