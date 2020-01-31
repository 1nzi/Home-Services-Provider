
import 'package:flutter/material.dart';
import 'c_change_passward.dart';
import 'c_drawer.dart';
import 'c_gender.dart';
import 'c_mobile.dart';
import 'c_update_email.dart';
import 'c_update_name.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Profile',
            style: new TextStyle(
                fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.lightGreen,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CustomerDrawerOnly();
                }));
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
          leading: Icon(Icons.person, color: Colors.lightGreen,size: 24,),
          title: Text(
            'Name',
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text('Arslan Ahmad'),
          trailing: IconButton(
              icon: Icon(Icons.edit, color: Colors.lightGreen, size: 24 ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateName();
                }));
              }),
        ),
        ListTile(
          leading: Icon(Icons.phone_android, color: Colors.lightGreen, size:24),
          title: Text(
            'Mobile Number',
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text('03164641478'),
          trailing: IconButton(
              icon: Icon(Icons.edit, color: Colors.lightGreen, size: 24),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Mobile();
                }));
              }),
        ),
//        ListTile(
//          leading: Icon(Icons.location_on),
//          title: Text('Address'),
//          subtitle: Text('Rajpoot Park Shad Bagh Lahore'),
//          trailing: IconButton(
//              icon: Icon(Icons.edit),
//              onPressed: () {
//                Navigator.push(context, MaterialPageRoute(builder: (context) {
//                  return UpdateName();
//                }));
//              }),
//        ),
        ListTile(
          leading: Icon(Icons.email, color: Colors.lightGreen, size:24),
          title: Text(
            'email',
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text('bitf16m030@pucit.edu.pk'),
          trailing: IconButton(
              icon: Icon(Icons.edit, color: Colors.lightGreen, size: 24),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateEmail();
                }));
              }),
        ),
        ListTile(
          leading: Icon(Icons.lock, color: Colors.lightGreen, size:24),
          title: Text(
            'Change Password',
            style: TextStyle(color: Colors.black),
          ),
          trailing: IconButton(
              icon: Icon(Icons.edit, color: Colors.lightGreen, size: 24),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChangePassword();
                }));
              }),
        ),
        ListTile(
          leading: Icon(Icons.supervisor_account, color: Colors.lightGreen, size: 24),
          title: Text(
            'Gender',
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text('Male'),
          trailing: IconButton(
              icon: Icon(Icons.edit, color: Colors.lightGreen, size: 24),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Gender();
                }));
              }),
        ),
      ],
    );
  }
}
