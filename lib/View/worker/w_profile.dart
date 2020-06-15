import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_well/Model/WorkerModel/WorkerProfileModel.dart';

import 'w_change_passward.dart';
import 'w_update_address.dart';
import 'w_update_email.dart';
import 'w_update_mobile.dart';
import 'w_update_name.dart';

WorkerDataFromFireStore workerDataFromFireStore  =
new  WorkerDataFromFireStore();

class WProfile extends StatefulWidget {

  @override
  WProfileState createState() => WProfileState();
}

class WProfileState extends State<WProfile> {

  SharedPreferences sp;
  String uid;
  String name;
  String email;
  String ph;
  String city;
  String password;

  @override
  void initState() {
    initSp();
    super.initState();
  }

  initSp() {
    workerDataFromFireStore.getSharedPreferences().then((value) {
      setState(() {
        sp = value;
        getUserInfo();
      });
    });
  }

  getUserInfo() async {
    uid=   sp.getString("workerId");
    name = sp.getString('wName');
    email = sp.getString('email');
    ph = sp.getString('ph');
    city = sp.getString('city');
    password = sp.getString('password');
  }

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
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person,color: Colors.lightGreen,),
              title: Text('Name'),
              subtitle: Text(name??'Name'),
              trailing: IconButton(
                  icon: Icon(Icons.edit,color: Colors.lightGreen,),
                  onPressed: () {
                    print("asdasdasdasdas : $uid");
                    Navigator.of(context).pushReplacement(

                        MaterialPageRoute(builder: (context) => WUpdateName(uid: uid)));
                  }),
            ),
            ListTile(
              leading: Icon(Icons.phone_android,color: Colors.lightGreen,),
              title: Text('Mobile Number'),
              subtitle: Text(ph??'phone No.'),
              trailing: IconButton(
                  icon: Icon(Icons.edit,color: Colors.lightGreen,),
                  onPressed: () {
                          Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => WMobile(uid: uid)));
                  }),
            ),
            ListTile(
              leading: Icon(Icons.location_on,color: Colors.lightGreen,),
              title: Text('Address',style: TextStyle(
                color: Colors.black,
              ),),
              subtitle: Text(city??"city"),
              trailing: IconButton(
                  icon: Icon(Icons.edit,color: Colors.lightGreen,),
                  onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                   return WorkerUpdateAddress(uid: uid,);
                               }));
                  }),
            ),
            ListTile(
              leading: Icon(Icons.email,color: Colors.lightGreen,),
              title: Text('email'),
              subtitle: Text(email??"email"),
              trailing: IconButton(
                  icon: Icon(Icons.edit,color: Colors.lightGreen,),
                  onPressed: () {
                              Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => WUpdateEmail(uid: uid,)));
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
        ),
      );
  }
}

