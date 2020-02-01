import 'package:flutter/material.dart';
import 'w_notification_details.dart';

class MyNotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyNotificationScreenState();
}

class _MyNotificationScreenState extends State<MyNotificationScreen> {
  // ignore: non_constant_identifier_names
  final List<Notification> notify = NotificationList.getNotification();

  Widget _buildNotificationList() {
    return Container(
      child: notify.length > 0
          ? ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: notify.length,
          itemBuilder: (BuildContext context, int index) {
            return NotificationDisplayDetails(notify: notify[index]);
          }
      )
          : Center(child: Text('No Items')),
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

        title: new Text("Notifications Details",
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),

      ),

      body: _buildNotificationList(),
    );
  }
}

class Notification{
  final Icon ProfileIcon;
  final String WorkerInfo;
  final String UserInfo;

  Notification(this.ProfileIcon, this.WorkerInfo, this.UserInfo);
}

class NotificationList
{
  static Icon _BellIcon = new Icon(
    Icons.notifications_active,
    size: 30,
    color: Colors.lightGreen,
  );
  static List<Notification> getNotification(){
    return[
      Notification(
        _BellIcon,
        "You Have A work request",
        "by the user"
      ),
      Notification(
          _BellIcon,
          "You Have A work request",
          "by the user"
      ),
      Notification(
          _BellIcon,
          "You Have A work request",
          "by the user"
      )
    ];
  }
}

class NotificationDisplayDetails extends StatelessWidget{

  final Notification notify;

  const NotificationDisplayDetails({ this.notify});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
        children: <Widget>[
        GestureDetector(
        onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyNotificationDetails()));
          },
          child:Row(
            children: <Widget>[
              notify.ProfileIcon,
              Padding(
                padding: EdgeInsets.only(left: 20),
              ),
              Column(
                children: <Widget>[
                  Text(notify.WorkerInfo),
                  Text(notify.UserInfo)
                ],
              )
            ],
          )
        ),
          Padding(
            padding: EdgeInsets.only(top: 30),
          )

        ],
    );
  }

}