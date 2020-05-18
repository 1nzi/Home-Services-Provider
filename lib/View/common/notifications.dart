import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseNotifications extends StatefulWidget{
  FirebaseNotifications():super();
  final String title= "Firebase Notification";
  @override
  State<StatefulWidget> createState() => FirebaseNotificationState();
  }

List<Message> _message;
class FirebaseNotificationState extends State<FirebaseNotifications> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
 _getToken(){
   _firebaseMessaging.getToken().then((deviceToken){
     print("device token: $deviceToken");
   });
 }

 _configureFirebaseListeners(){
   _firebaseMessaging.configure(
     onMessage: (Map<String, dynamic> message) async{
       _setMessage(message);
       },
     onLaunch: (Map<String, dynamic> message) async{
       _setMessage(message);
     },
     onResume: (Map<String, dynamic> message) async{
       _setMessage(message);
     },
   );
 }

 _setMessage(Map<String, dynamic> message){
   final notification = message['notification'];
   final data = message['data'];
   final String title = notification['title'];
   final String body = notification['body'];
   final String  mMessage = data['message'];
   setState((){
     Message m = Message(title, body, mMessage);
     _message.add(m);
   });
 }

 @override
  void initState() {
    super.initState();
    _message = List<Message>();
    _getToken();
    _configureFirebaseListeners();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: null == _message ? 0 : _message.length,
          itemBuilder: (context, index){
            return Card(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  _message[index].message,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }),
    );
  }

}

class Message{
  String title;
  String body;
  String message;
  Message(title, body, message ){
    this.title = title;
    this.body = body;
    this.message = message;
  }
}