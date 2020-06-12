import 'package:flutter/material.dart';
import 'package:home_well/Model/CustomerModel/customerProfileModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'c_change_passward.dart';
import 'c_gender.dart';
import 'c_mobile.dart';
import 'c_update_email.dart';
import 'c_update_name.dart';

CustomerDataFromFireStore customerDataFromFireStore =
new CustomerDataFromFireStore();

class Profile extends StatefulWidget {
  //final CustomerData user;

  //const Profile({Key key, this.user}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  //final CustomerData customerData;

  //ProfileState(this.customerData);

  SharedPreferences sp;
  String uid;
  String name;
  String email;
  String ph;
  String address;
  String gender;
  String password;


  @override
  void initState() {
    initSp();
    super.initState();
  }
  initSp() {
    customerDataFromFireStore.getSharedPreferences().then((value) {
      setState(() {
        sp = value;
        getUserInfo();
      });
    });
  }

  getUserInfo() async {
    uid=sp.getString('userId');
    name = sp.getString('cName');
    email = sp.getString('email');
    gender = sp.getString('gender');
    ph = sp.getString('ph');
    address = sp.getString('address');
    password = sp.getString('password');
  }
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
              Navigator.pop(context);
            }),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person, color: Colors.lightGreen,size: 24,),
            title: Text(
              'Name',
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(name??'Name'),
            trailing: IconButton(
                icon: Icon(Icons.edit, color: Colors.lightGreen, size: 24 ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => UpdateName(uid: uid)));
                }),
          ),
          ListTile(
            leading: Icon(Icons.phone_android, color: Colors.lightGreen, size:24),
            title: Text(
              'Mobile Number',
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(ph??'phone No.'),
            trailing: IconButton(
                icon: Icon(Icons.edit, color: Colors.lightGreen, size: 24),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Mobile(uid: uid)));

                }),
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Address'),
            subtitle: Text(address??"address"),
            trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return UpdateName(uid: uid,);
                  }));
                }),
          ),
          ListTile(
            leading: Icon(Icons.email, color: Colors.lightGreen, size:24),
            title: Text(
              'email',
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(email??'email'),
            trailing: IconButton(
                icon: Icon(Icons.edit, color: Colors.lightGreen, size: 24),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => UpdateEmail(uid: uid,)));
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
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ChangePassword(uid: uid, uPassw: password,)));
                }),
          ),
          ListTile(
            leading: Icon(Icons.supervisor_account, color: Colors.lightGreen, size: 24),
            title: Text(
              'Gender',
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(gender??'gender'),
            trailing: IconButton(
                icon: Icon(Icons.edit, color: Colors.lightGreen, size: 24),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Gender(uid: uid)));
                }),
          ),
        ],
      ),
    );
  }
}