import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'w_change_passward.dart';
import 'w_update_address.dart';
import 'w_update_email.dart';
import 'w_update_mobile.dart';
import 'w_update_name.dart';


class WorkerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Colors.lightGreen,
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
            Navigator.pop(context);
          }),
        ),
        body: ListItems(),
      );
  }
}

class ListItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.person,color: Colors.lightGreen,),
          title: Text('Name'),
          subtitle: Text('Arslan Ahmad'),
          trailing: IconButton(
              icon: Icon(Icons.edit,color: Colors.lightGreen,),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WorkerUpdateName();
                }));
              }),
        ),
        ListTile(
          leading: Icon(Icons.phone_android,color: Colors.lightGreen,),
          title: Text('Mobile Number'),
          subtitle: Text('03164641478'),
          trailing: IconButton(
              icon: Icon(Icons.edit,color: Colors.lightGreen,),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WorkerMobile();
                }));
              }),
        ),
        ListTile(
          leading: Icon(Icons.location_on,color: Colors.lightGreen,),
          title: Text('Address',style: TextStyle(
            color: Colors.black,
          ),),
          subtitle: Text('Lahore'),
          trailing: IconButton(
              icon: Icon(Icons.edit,color: Colors.lightGreen,),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WorkerUpdateAddress();
                }));
              }),
        ),
        ListTile(
          leading: Icon(Icons.email,color: Colors.lightGreen,),
          title: Text('email'),
          subtitle: Text('bitf16m030@pucit.edu.pk'),
          trailing: IconButton(
              icon: Icon(Icons.edit,color: Colors.lightGreen,),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WorkerUpdateEmail();
                }));
              }),
        ),
        ListTile(
          leading: Icon(Icons.lock,color: Colors.lightGreen,),
          title: Text('Change Password '),
          trailing: IconButton(
              icon: Icon(Icons.edit,color: Colors.lightGreen,),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WorkerChangePassword();
                }));
              }),
        ),
      ],
    );
  }
}
