import 'package:flutter/material.dart';
import 'w_notification_details.dart';

class MyNotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyNotificationScreenState();
}

class _MyNotificationScreenState extends State<MyNotificationScreen> {
  // ignore: non_constant_identifier_names
  Icon _BellIcon = new Icon(
    Icons.notifications_active,
    size: 30,
    color: Colors.lightGreen,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Work Notifications"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child:ListView(padding: EdgeInsets.all(24), children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyNotificationDetails()));
            },
            child: Row(
              children: <Widget>[
                _BellIcon,
                Padding(
                  padding: EdgeInsets.only(left: 20),
                ),
                Column(
                  children: <Widget>[
                    Text("You Have A work request"),
                    Text("by the user")
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyNotificationDetails()));
            },
            child: Row(
              children: <Widget>[
                _BellIcon,
                Padding(
                  padding: EdgeInsets.only(left: 20),
                ),
                Column(
                  children: <Widget>[
                    Text("You Have A work request"),
                    Text("by the user")
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyNotificationDetails()));
            },
            child: Row(
              children: <Widget>[
                _BellIcon,
                Padding(
                  padding: EdgeInsets.only(left: 20),
                ),
                Column(
                  children: <Widget>[
                    Text("You Have A work request"),
                    Text("by the user")
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyNotificationDetails()));
            },
            child: Row(
              children: <Widget>[
                _BellIcon,
                Padding(
                  padding: EdgeInsets.only(left: 20),
                ),
                Column(
                  children: <Widget>[
                    Text("You Have A work request"),
                    Text("by the user")
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
