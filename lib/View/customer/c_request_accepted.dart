import 'package:flutter/material.dart';

import 'c_rating_bar.dart';

class AcceptedRequest extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return AcceptedRequestPage();
  }
}
  class AcceptedRequestPage extends State<AcceptedRequest> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(
            title: Text('Request Accepted',
              style: new TextStyle(
                  fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
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
                Text('Your request has been accepted by',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontFamily: 'Raleway',
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),

                new FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => RatingBar()));
                  },
                  child: Text('Worker',
                      style: TextStyle(color: Colors.lightGreen, fontSize: 30, )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                Text(
                  'You may contact',
                    style: TextStyle(
                      fontSize: 18,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                RaisedButton(
                  color: Colors.lightGreen,
                  child: Text('Contact',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => new RatingBar()));

                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
              ],
            ),
          )
    );
  }

}
